class GoogleDestinationService
  def initialize(start, des)
    @start = start
    @des = des
  end 

  def travel_time
    resp['routes'][0]['legs'][0]['duration']['text']
  end

  def end_location
    resp['routes'][0]['legs'][0]['end_address']
  end

  def lat 
    resp['routes'][0]['legs'][0]['end_location']['lat']
  end

  def lng
    resp['routes'][0]['legs'][0]['end_location']['lng']
  end

  private
  
  def resp
    JSON.parse(conn.body, symbolize_name: true)
  end

  def conn
    Faraday.get('https://maps.googleapis.com/maps/api/directions/json') do |f|
      f.params['key'] = ENV['GOOGLE_API_KEY']
      f.params['origin'] = @start
      f.params['destination'] = @des
    end
  end
end