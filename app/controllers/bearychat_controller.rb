class BearychatController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def movie
    # /bearychat/movie?text=!电影 大鱼海棠&trigger_word=!电影

    text = params[:text]
    trigger_word = params[:trigger_word]

    name = text.gsub(trigger_word, "").strip
    url = "https://api.douban.com/v2/movie/search?q=#{URI.encode(name)}"

    begin
      response = RestClient.get(url)
      data = JSON.parse(response.to_str)

      if data['subjects'].length > 0
        subject = data['subjects'][0]

        id = subject['id']
        detail = RestClient.get("https://api.douban.com/v2/movie/subject/#{id}")
        detail = JSON.parse(detail.to_str)
        
        return render :json => {
          text: "#{name} 查询结果",
          attachments: [
            {
              color: '#FFD596',
              images: [
                {url: detail['images']['large']}
              ]
            },
            {
              title: '豆瓣页面',
              text: detail['alt'],
              color: '#FFD596'
            },
            {
              title: '基本信息',
              text: "评分：#{subject['rating']['average']}，类型：#{detail['genres'].join(' ')}，年份：#{detail['year']}，国家：#{detail['countries'].join(' ')}",
              color: '#FFD596'
            },
            {
              title: '简介',
              text: detail['summary'],
              color: '#FFD596'
            }
          ]
        }

      else
        return render :json => {
          text: "没有查询到电影信息"
        }
      end

    rescue  => e
      return render :json => {
        text: "没有查询到电影信息"
      }
    end
  end

  def weather
    # params[:text] = "!天气 北京"
    # params[:trigger_word] = "!天气"

    text         = params[:text]
    trigger_word = params[:trigger_word]
    location = text.gsub(trigger_word, "").strip
    url = "https://api.thinkpage.cn/v3/weather/daily.json?key=wfqr65dxtgiyaryt&location=#{URI.encode(location)}&language=zh-Hans&unit=c&start=0&days=5"

    begin
      response = RestClient.get(url)
      data = JSON.parse(response.to_str)
      if data['results']

        arr = data['results'][0]['daily'].map {|d|
          {
            title: d['date'],
            text: "白天：#{d['text_day']}，夜间：#{d['text_night']}，温度：#{d['low']}℃ - #{d['high']}℃，风向：#{d['wind_direction']}，风力：#{d['wind_scale']} 级",
            color: '#317BCF'
          }
        }

        return render :json => {
          text: "#{location}天气预报",
          attachments: arr
        }

      else
        return render json: {
          text: '没有查询到天气信息'
        }
      end

    rescue => e
      return render :json => {
        text: "没有查询到天气信息"
      }
    end
  end

  def deploy
    # /bearychat/deploy
    # text=!deploy
    # trigger_word=!deploy
    # user_name=ben7th
    # channel_name=服务部署

    user_name = params[:user_name]
    channel_name = params[:channel_name]

    begin
      if user_name != 'ben7th' or channel_name != '服务部署'
        return render json: {
          text: '没有部署权限，目前只能由 ben7th 运行'
        }
      end

      FileUtils.cd '/home/mina/demo-center-youthedu' do
        system('/home/mina/demo-center-youthedu/auto_mina_deploy.sh')
      end

      return render json: {
        text: '开始部署',
        attachments: [
          {
            title: '签出地址',
            text: 'https://github.com/mindpin/demo-center-youthedu',
          },
          {
            title: '签出分支',
            text: 'master'
          }
        ]
      }
    rescue => e
      return render json: {
        text: '机器人请求异常'
      }
    end
  end

  def task
    # /bearychat/task
    # text=!task [member]
    # trigger_word=!task
    # user_name=ben7th

    text         = params[:text]

    user_name = params[:user_name]
    member = text.gsub('!task', '').strip
    user_name = member if member.present?

    projects = YAML.load_file File.join(Rails.root, 'demo-data', 'tasks.yaml')

    attachments = []
    projects.each { |p|
      if t = p[user_name]
        attachments << {
          title: p['project'],
          text: t
        }
      end
    }


    return render json: {
      text: "#{user_name} 目前有以下工作：",
      attachments: attachments
    }
  end
end