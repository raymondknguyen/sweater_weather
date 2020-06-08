require 'rails_helper'

RSpec.describe "Food Request", :type => :request  do
  it 'can retrieve food and forecast for a destination city' do
    get "/api/v1/foodie?start=denver,co&end=pueblo,co&search=italian"
    expect(response).to be_successful
  end
end