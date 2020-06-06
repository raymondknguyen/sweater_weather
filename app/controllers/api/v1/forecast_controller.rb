class Api::V1::ForecastController < ApplicationController
  def index
     response = Faraday.get('https://maps.googleapis.com/maps/api/geocode/json') do |f|
      f.params['key'] = ENV['GOOGLE_GEOCODING_API_KEY']
      f.params['address'] = params[:location]
    end
    JSON.parse(response.body, symbolize_names: true)
  
    binding.pry
  end
end