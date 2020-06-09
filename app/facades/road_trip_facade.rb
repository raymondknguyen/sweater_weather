class RoadTripFacade
  attr_reader :id,
              :origin,
              :destination

  def initialize(origin, destination)
    @origin = origin
    @destination = destination
  end

  def arrival_forecast
    { temp: get_arrival_forecast[:temp],
      summary: get_arrival_forecast[:summary] }
  end
  
  def travel_time
    google_info.travel_time
  end
  
  private 

  def get_arrival_forecast
    get_weather.hourly_forecast[rounded_hours]
  end
  
  def rounded_hours
    min = DateTime.strptime(google_info.travel_time_value.to_s,'%s').strftime("%M").to_i
    hour = DateTime.strptime(google_info.travel_time_value.to_s,'%s').strftime("%I").to_i
    min >= 30 ? new_min = 3600 : new_min = 0
    rounded_time_unix = new_min + (hour * 3600) 
    rounded_hours = DateTime.strptime(rounded_time_unix.to_s,'%s').strftime("%I").to_i
  end

  def weather_info
    WeatherService.new(google_info.lat, google_info.lng)
  end

  def google_info
    GoogleDestinationService.new(@origin, @destination)
  end

  def get_weather
    WeatherFacade.new(@destination)
  end
end