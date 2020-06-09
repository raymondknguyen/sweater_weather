require 'rails_helper'


RSpec.describe "User Request", :type => :request do 
  it 'can log in' do
    email = 'email@email.com'
    password = 'password'

    post "/api/v1/users?email=#{email}&password=#{password}&password_confirmation=#{password}"

    expect(response).to be_successful
    data = JSON.parse(response.body , symbolize_names: true)
    expect(data[:data][:type]).to eq("user")
    expect(data[:data][:attributes][:email]).to eq("email@email.com")
    expect(data[:data][:attributes][:api_key]).to_not be_nil
    expect(response.status).to eq(201)
  end
end