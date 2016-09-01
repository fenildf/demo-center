class BearychatController < ApplicationController
  skip_before_filter :verify_authenticity_token

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

    rescue  => e
      return render :json => {
        text: "没有查询到天气信息"
      }
    end
  end
end