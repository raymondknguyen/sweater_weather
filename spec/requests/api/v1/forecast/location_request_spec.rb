require 'rails_helper'

RSpec.describe "Weather Request", :type => :request do 

  it "finds weather by location" do
    get "/api/v1/forecast?location=denver,co"
    expect(response).to be_successful
  end


end