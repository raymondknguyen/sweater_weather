class GeocodeService 
  attr_reader :location 

  def initialize(location)
    @location =  location 
  end

  def location_info
    JSON.parse(resp.body, symbolize_names: true)
  end

  def resp
    Faraday.get('https://maps.googleapis.com/maps/api/geocode/json') do |f|
      f.params['key'] = ENV['GOOGLE_GEOCODING_API_KEY']
      f.params['address'] = @location
    end
  end
end