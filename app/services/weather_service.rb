class WeatherService
  def initialize(lat, lng)
    @lat = lat
    @lng = lng
  end
  def weather_info
    resp = Faraday.get('https://api.openweathermap.org/data/2.5/onecall') do |f|
      f.params[:appid] = ENV['WEATHER_API_KEY']
      f.params[:lat] = @lat
      f.params[:lon] = @lng
      f.params[:units] = "imperial"
    end

    JSON.parse(resp.body, symbolize_names: true)
  end
end