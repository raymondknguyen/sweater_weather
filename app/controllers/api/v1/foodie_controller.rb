class Api::V1::FoodieController < ApplicationController
  def index
  start = params[:start] 
  des = params[:end]
  search = params[:search]

    location_info = GoogleDestinationService.new(start, des)
    location_info.travel_time
    location_info.end_location

    weather = WeatherService.new(location_info.lat, location_info.lng).weather_info
    summary = weather[:current][:weather][0][:description]
    temp = weather[:current][:temp].to_i

    restaurant_info = ZomatoService.new(location_info.lat, location_info.lng, search)
    name = restaurant_info.name
    address = restaurant_info.address
    binding.pry
  end
end