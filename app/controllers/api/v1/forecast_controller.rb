class Api::V1::ForecastController < ApplicationController
  def index
     conn = Faraday.get('https://maps.googleapis.com/maps/api/geocode/json') do |f|
      f.params['key'] = ENV['GOOGLE_GEOCODING_API_KEY']
      f.params['address'] = params[:location]
    end
    location_info = JSON.parse(conn.body, symbolize_names: true)
  
    lat = location_info[:results][0][:geometry][:location][:lat]
    lng = location_info[:results][0][:geometry][:location][:lng]

    city = location_info[:results].first[:address_components][0][:long_name]
    state = location_info[:results].first[:address_components][2][:long_name]
    country = location_info[:results].first[:address_components][3][:long_name]

    current_time = DateTime.now.strftime "%I:%M %P, %B %d"

    resp = Faraday.get('https://api.openweathermap.org/data/2.5/onecall') do |f|
      f.params[:appid] = ENV['WEATHER_API_KEY']
      f.params[:lat] = lat
      f.params[:lon] = lng
      f.params[:units] = "imperial"
    end
    weather_info = JSON.parse(resp.body, symbolize_names: true)

    summary = weather_info[:current][:weather][0][:description]
    temp = weather_info[:current][:temp]
    feels_like = weather_info[:current][:feels_like]
    humidity = weather_info[:current][:humidity]
    visibility = weather[:current][:visibility] 
    uv_index = weather_info[:current][:uvi]

    sunrise = weather_info[:current][:sunrise] + weather_info[:timezone_offset]
    sunset = weather_info[:current][:sunset] + weather_info[:timezone_offset]

    DateTime.strptime(sunrise.to_s,'%s').strftime("%I:%M %P")
    DateTime.strptime(sunset.to_s,'%s').strftime("%I:%M %P")


    temp_low = weather_info[:daily][0][:temp][:min].to_i
    temp_high = weather_info[:daily][0][:temp][:max].to_i

    #hourly
    hourly_temp = weather_info[:hourly][0..7].map do |forecast|
      { time: DateTime
        .strptime((forecast[:dt] + weather_info[:timezone_offset])
        .to_s,'%s')
        .strftime("%l %P"), 
       temp: forecast[:temp].to_i }
    end

    #daily
    weekly_forecast = weather_info[:daily][0..6].map do |forecast|
        { day: DateTime
          .strptime((forecast[:dt] + weather_info[:timezone_offset])
          .to_s,'%s')
          .strftime("%A"),
        summary: forecast[:weather][0][:main],
        rain: forecast[:rain] ? "#{forecast[:rain]} mm" : "0 mm",
        temp_max: forecast[:temp][:max].to_i,
        temp_min: forecast[:temp][:min].to_i }
    end 

    binding.pry
  end
end