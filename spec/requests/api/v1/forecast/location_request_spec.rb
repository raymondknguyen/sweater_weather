require 'rails_helper'


RSpec.describe "Weather Request", :type => :request do 

  it "finds weather by location", :vcr do
    get "/api/v1/forecast?location=denver,co"
    expect(response).to be_successful
    data = JSON.parse(response.body, symbolize_names: true)
    expect(data[:data][:type]).to eq("weather")
    expect(data[:data][:attributes][:location_info][:city]).to eq("Denver")
    expect(data[:data][:attributes][:location_info][:state]).to eq("Colorado")
    expect(data[:data][:attributes][:location_info][:country]).to eq("United States")
    expect(data[:data][:attributes][:current_time]).to_not be_nil
    expect(data[:data][:attributes][:summary]).to_not be_nil
    expect(data[:data][:attributes][:temp]).to_not be_nil
    expect(data[:data][:attributes][:temp_high]).to_not be_nil
    expect(data[:data][:attributes][:temp_low]).to_not be_nil
    expect(data[:data][:attributes][:feels_like]).to_not be_nil
    expect(data[:data][:attributes][:humidity]).to_not be_nil
    expect(data[:data][:attributes][:visibility]).to_not be_nil
    expect(data[:data][:attributes][:uv_index]).to_not be_nil
    expect(data[:data][:attributes][:sunrise]).to_not be_nil
    expect(data[:data][:attributes][:sunset]).to_not be_nil
  end

  it "can find background picture", :vcr do
    get '/api/v1/backgrounds?location=denver,co'
    expect(response).to be_successful
    data = JSON.parse(response.body, symbolize_names: true)
    expect(data[:data][:type]).to eq("background")
    expect(data[:data][:attributes][:location_url]).to_not be_nil
    
  end
end