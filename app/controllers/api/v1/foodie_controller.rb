class Api::V1::FoodieController < ApplicationController
  def index
  start = params[:start] 
  des = params[:end]
  search = [:search]
  
    resp = Faraday.get('https://maps.googleapis.com/maps/api/directions/json') do |f|
      f.params['key'] = ENV['GOOGLE_API_KEY']
      f.params['origin'] = start
      f.params['destination'] = des
    end
    x = JSON.parse(resp.body, symbolize_name: true)
    travel_time = x['routes'][0]['legs'][0]['duration']['text']
    end_location = x['routes'][0]['legs'][0]['end_address']

    lat = x['routes'][0]['legs'][0]['end_location']['lat']
    lng = x['routes'][0]['legs'][0]['end_location']['lng']

    weather = WeatherService.new(lat, lng).weather_info
    summary = weather[:current][:weather][0][:description]
    temp = weather[:current][:temp].to_i

    # resp = Faraday.get('https://maps.googleapis.com/maps/api/directions/json') do |f|
    #   f.params['key'] = ENV['GOOGLE_API_KEY']
    #   f.params['origin'] = start
    #   f.params['destination'] = des
    # end

    binding.pry
  end
end