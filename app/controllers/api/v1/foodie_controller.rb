class Api::V1::FoodieController < ApplicationController
  def index
  start = params[:start] 
  des = params[:end]
  search = params[:search]
  
    # resp = Faraday.get('https://maps.googleapis.com/maps/api/directions/json') do |f|
    #   f.params['key'] = ENV['GOOGLE_API_KEY']
    #   f.params['origin'] = start
    #   f.params['destination'] = des
    # end
    # x = JSON.parse(resp.body, symbolize_name: true)


    # travel_time = x['routes'][0]['legs'][0]['duration']['text']
    # end_location = x['routes'][0]['legs'][0]['end_address']
    # lat = x['routes'][0]['legs'][0]['end_location']['lat']
    # lng = x['routes'][0]['legs'][0]['end_location']['lng']

    location_info = GoogleDestinationService.new(start, des)
    location_info.travel_time
    location_info.end_location

    weather = WeatherService.new(location_info.lat, location_info.lng).weather_info
    summary = weather[:current][:weather][0][:description]
    temp = weather[:current][:temp].to_i

    resp = Faraday.get('https://developers.zomato.com/api/v2.1/search') do |f|
      f.headers['user-key'] = ENV['ZOMATO_API_KEY']
      f.params['lat'] = location_info.lat
      f.params['lon'] = location_info.lng
      f.params['q'] = search
    end
    x = JSON.parse(resp.body, symbolize_name: true)
    name = x['restaurants'][0]['restaurant']['name']
    address = x['restaurants'][0]['restaurant']['location']['address']
    binding.pry
  end
end