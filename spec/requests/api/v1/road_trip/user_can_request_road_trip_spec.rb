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

    expect(response).to be_successful
    data = JSON.parse(response.body , symbolize_names: true)
    expect(data[:data][:type]).to eq("road_trip")
    expect(data[:data][:attributes][:origin]).to eq("Denver,CO")
    expect(data[:data][:attributes][:destination]).to eq("Pueblo,CO")
    expect(data[:data][:attributes][:travel_time]).to_not be_nil
    expect(data[:data][:attributes][:arrival_forecast][:temp]).to_not be_nil
    expect(data[:data][:attributes][:arrival_forecast][:summary]).to_not be_nil
  end

  it 'cant get request' do
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
    api_key: "wrongapi"
    }
    post '/api/v1/road_trip', params: param

    expect(response).to_not be_successful
    data = JSON.parse(response.body , symbolize_names: true)
    expect(data[:error]).to eq("Bad credentials. Please double check login request.")
    expect(response.status).to eq(400)
  end
end