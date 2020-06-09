require 'rails_helper'

RSpec.describe "Food Request", :type => :request  do
  it 'can retrieve food and forecast for a destination city' do
    get "/api/v1/foodie?start=denver,co&end=pueblo,co&search=italian"
    expect(response).to be_successful
    data = JSON.parse(response.body, symbolize_names: true)
    expect(data[:data][:type]).to eq("foodie")
    expect(data[:data][:attributes][:end_location]).to eq("Pueblo, CO, USA")
    expect(data[:data][:attributes][:travel_time]).to eq("1 hour 48 mins")
    expect(data[:data][:attributes][:forecast][:summary]).to_not be_nil
    expect(data[:data][:attributes][:forecast][:temperature]).to_not be_nil
    expect(data[:data][:attributes][:restaurant][:name]).to eq("Angelo's Pizza Parlor")
    expect(data[:data][:attributes][:restaurant][:address]).to eq("105 E Riverwalk, Pueblo 81003")
  end
end