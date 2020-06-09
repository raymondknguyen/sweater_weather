class WeatherFacade
  attr_reader :location,
              :id
  
  def initialize(location)
    @location = location
    @id = nil
  end

  def location_info
    {city: geocode.city, state: geocode.state, country: geocode.country}
  end

  def current_time
    DateTime.now.strftime "%I:%M %p, %B %d"
  end
  
  def summary
    weather_info[:current][:weather][0][:description].titleize
  end

  def temp
    weather_info[:current][:temp].to_i
  end 
  
  def feels_like
    weather_info[:current][:feels_like].to_i
  end
  
  def humidity 
    "#{weather_info[:current][:humidity]}%"
  end

  def visibility
    "#{weather_info[:current][:visibility]} miles"
  end
  
  def uv_index
    weather_info[:current][:uvi]
  end
  
  def sunrise
    sunrise = weather_info[:current][:sunrise] + weather_info[:timezone_offset]
    DateTime.strptime(sunrise.to_s,'%s').strftime("%I:%M %p")
  end

  def sunset
    sunset = weather_info[:current][:sunset] + weather_info[:timezone_offset]
    DateTime.strptime(sunset.to_s,'%s').strftime("%I:%M %p")
  end

  def temp_high
    weather_info[:daily][0][:temp][:max].to_i
  end

  def temp_low
    weather_info[:daily][0][:temp][:min].to_i
  end

  def hourly_forecast
    weather_info[:hourly][0..7].map do |forecast|
      { time: DateTime
            .strptime((forecast[:dt] + weather_info[:timezone_offset])
            .to_s,'%s')
            .strftime("%l %p"), 
        temp: forecast[:temp].to_i,
        summary: forecast[:weather][0][:description] }
    end
  end

  def daily_forecast
    weather_info[:daily][0..6].map do |forecast|
      { day: DateTime
            .strptime((forecast[:dt] + weather_info[:timezone_offset])
            .to_s,'%s')
            .strftime("%A"),
        summary: forecast[:weather][0][:main],
        rain: forecast[:rain] ? "#{forecast[:rain]} mm" : "0 mm",
        temp_max: forecast[:temp][:max].to_i,
        temp_min: forecast[:temp][:min].to_i }
    end 
  end

  private 

  def weather_info
    WeatherService.new(geocode.lat, geocode.lng).weather_info
  end 

  def geocode
    GeocodeService.new(location)
  end
end