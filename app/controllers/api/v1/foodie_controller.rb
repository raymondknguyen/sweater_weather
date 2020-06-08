class Api::V1::FoodieController < ApplicationController
  def index
  start = params[:start] 
  des = params[:end]
  search = [:search]
  
    resp = Faraday.get('https://maps.googleapis.com/maps/api/directions/json') do |f|
      f.params['key'] = ENV['GOOGLE_API_KEY']
      f.params['origin'] = start
      f.params['destination'] = des
    end
    x = JSON.parse(resp.body, symbolize_name: true)
    x['routes'][0]['legs'][0]['duration']['text']
    binding.pry
  end
end