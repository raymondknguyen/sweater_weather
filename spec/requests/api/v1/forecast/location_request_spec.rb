require 'rails_helper'

RSpec.describe "Weather Request", :type => :request do 

  it "finds weather by location", :vcr do
    get "/api/v1/forecast?location=denver,co"
    expect(response).to be_successful
  end

  it "can find background picture" do
    get '/api/v1/backgrounds?location=denver,co'
    expect(response).to be_successful
  end
end