class BackgroundService 
  attr_reader :location,
              :id
  def initialize(location)
    @location = location
    @id = nil
  end

  def location_url
    get_picture[:results][0][:urls][:raw]
  end

  private

  def get_picture
    JSON.parse(resp.body, symbolize_names: true)
  end
  
  def resp
   Faraday.get('https://api.unsplash.com/search/photos') do |f|
      f.params['client_id'] = ENV['UNSPLASH_API_KEY']
      f.params['query'] = @location
    end
  end 
end