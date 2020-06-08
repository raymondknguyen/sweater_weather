class GeocodeService 
 def initialize(location)
    @location =  location 
  end

  def city
    location_info[:results].first[:address_components][0][:long_name]
  end

  def state
    location_info[:results].first[:address_components][2][:long_name]
  end

  def country
    location_info[:results].first[:address_components][3][:long_name]
  end

  def lng
    location_info[:results][0][:geometry][:location][:lng]
  end

  def lat
    location_info[:results][0][:geometry][:location][:lat]
  end

  private

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