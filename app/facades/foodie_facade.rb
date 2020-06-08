class FoodieFacade
  attr_reader :id

  def initialize(start, des, search)
    @start = start
    @des = des 
    @search = search 
    @id = nil
  end

  def travel_time
    location_info.travel_time
  end

  def end_location
    location_info.end_location
  end

  def summary
    weather[:current][:weather][0][:description]
  end
  
  def temp
    weather[:current][:temp].to_i.to_s
  end

  def name
    restaurant_info.name
  end

  def address
    restaurant_info.address
  end

  private
  
  def restaurant_info
     ZomatoService.new(location_info.lat, location_info.lng, @search)
  end
  
  def weather
    WeatherService.new(location_info.lat, location_info.lng).weather_info
  end

  def location_info
    GoogleDestinationService.new(@start, @des)
  end
end