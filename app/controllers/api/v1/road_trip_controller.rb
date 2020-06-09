class Api::V1::RoadTripController < ApplicationController
  def create
    if User.find_by(api_key: params[:api_key])
      info = GoogleDestinationService.new(params[:origin], params[:destination])
      travel_time = info.travel_time
      travel_value = info.travel_time_value
      lat = info.lat
      lng = info.lng
      weather = WeatherService.new(lat, lng)
      weather.weather_info

      min = DateTime.strptime(travel_value.to_s,'%s').strftime("%M").to_i
      hour = DateTime.strptime(travel_value.to_s,'%s').strftime("%I").to_i
      min >= 30 ? new_min = 3600 : new_min = 0
      rounded_time_unix = new_min + (hour * 3600) 
      rounded_hours = DateTime.strptime(rounded_time.to_s,'%s').strftime("%I").to_i

      weather = WeatherFacade.new(params[:destination])

      weather.hourly_forecast[rounded_hours]
      binding.pry 

    end
  end
end