require 'rails_helper'

RSpec.describe "RoadTrip Request", :type => :request do 
  it 'can request roadtrip information' do
    user = User.create({
      email: 'email@@email', 
      password: 'password',
      password_confirmation: 'password'
    })
    user.api_key = "jgn983hy48thw9begh98h4539h4"
    user.save

    param = {
    origin: "Denver,CO",
    destination: "Pueblo,CO",
    api_key: "jgn983hy48thw9begh98h4539h4"
    }
    post '/api/v1/road_trip', params: param


  end
end