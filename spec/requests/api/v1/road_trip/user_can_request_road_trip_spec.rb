require 'rails_helper'

RSpec.describe "RoadTrip Request", :type => :request do 
  it 'can request roadtrip information' do
    param = {
    origin: "Denver,CO",
    destination: "Pueblo,CO",
    api_key: "jgn983hy48thw9begh98h4539h4"
    }
    post '/api/v1/road_trip', params: param

    
  end
end