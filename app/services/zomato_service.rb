class ZomatoService
  def initialize(lat, lng, search)
    @lat = lat
    @lng = lng
    @search = search 
  end

  def name 
    response['restaurants'][0]['restaurant']['name']
  end

  def address
    response['restaurants'][0]['restaurant']['location']['address']
  end

  private

  def response 
    JSON.parse(conn.body, symbolize_name: true)
  end

  def conn
    Faraday.get('https://developers.zomato.com/api/v2.1/search') do |f|
      f.headers['user-key'] = ENV['ZOMATO_API_KEY']
      f.params['lat'] = @lat
      f.params['lon'] = @lng
      f.params['q'] = @search
    end
  end
end