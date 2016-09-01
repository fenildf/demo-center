class BearychatController < ApplicationController

  def weather
  	# params[:text] = "!天气 北京"
  	# params[:trigger_word] = "!天气"

    text         = params[:text]
    trigger_word = params[:trigger_word]
    location = text.gsub(trigger_word, "").strip
    url = "https://api.thinkpage.cn/v3/weather/daily.json?key=wfqr65dxtgiyaryt&location=#{URI.encode(location)}&language=zh-Hans&unit=c&start=0&days=5"

    response = RestClient.get(url)
    if response.code != 200
      return render :json => {
        text: "服务暂时不可用"
      }
    end

    data = JSON.parse(response.to_str)
    # {
    #   "results": [
    #     {
    #       "location": {
    #         "id": "WX4FBXXFKE4F",
    #         "name": "北京",
    #         "country": "CN",
    #         "path": "北京,北京,中国",
    #         "timezone": "Asia/Shanghai",
    #         "timezone_offset": "+08:00"
    #       },
    #       "daily": [
    #         {
    #           "date": "2016-09-01",
    #           "text_day": "阴",
    #           "code_day": "9",
    #           "text_night": "阴",
    #           "code_night": "9",
    #           "high": "27",
    #           "low": "19",
    #           "precip": "",
    #           "wind_direction": "北",
    #           "wind_direction_degree": "0",
    #           "wind_speed": "15",
    #           "wind_scale": "3"
    #         },
    #         {
    #           "date": "2016-09-02",
    #           "text_day": "阴",
    #           "code_day": "9",
    #           "text_night": "多云",
    #           "code_night": "4",
    #           "high": "28",
    #           "low": "19",
    #           "precip": "",
    #           "wind_direction": "无持续风向",
    #           "wind_direction_degree": "",
    #           "wind_speed": "10",
    #           "wind_scale": "2"
    #         },
    #         {
    #           "date": "2016-09-03",
    #           "text_day": "多云",
    #           "code_day": "4",
    #           "text_night": "阴",
    #           "code_night": "9",
    #           "high": "29",
    #           "low": "20",
    #           "precip": "",
    #           "wind_direction": "无持续风向",
    #           "wind_direction_degree": "",
    #           "wind_speed": "10",
    #           "wind_scale": "2"
    #         }
    #       ],
    #       "last_update": "2016-09-01T08:00:00+08:00"
    #     }
    #   ]
    # }

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

  end

end