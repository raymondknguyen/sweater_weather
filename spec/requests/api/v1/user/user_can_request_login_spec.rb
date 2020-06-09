require 'rails_helper'


RSpec.describe "User Request", :type => :request do 
  it 'can log in' do
    user_params = {
      email: 'email@email.com',
      password: 'password',
      password_confirmation: 'password'
    }
    User.create(user_params)

    user_params = {
      email: 'email@email.com',
      password: 'password',
    }

    post "/api/v1/sessions", params: user_params

    expect(response).to be_successful
    data = JSON.parse(response.body , symbolize_names: true)
    expect(data[:data][:type]).to eq("user")
    expect(data[:data][:attributes][:email]).to eq("email@email.com")
    expect(data[:data][:attributes][:api_key]).to_not be_nil
    expect(response.status).to eq(200)
  end

  it 'cant log in' do
    user_params = {
      email: 'email@email.com',
      password: 'password',
      password_confirmation: 'password'
    }
    User.create(user_params)

    user_params = {
      email: 'email@email.com',
      password: '',
    }

    post "/api/v1/sessions", params: user_params

    expect(response).to_not be_successful
    data = JSON.parse(response.body , symbolize_names: true)
    expect(data[:error]).to eq("Bad credentials. Please double check login request.")
    expect(response.status).to eq(400)
  end
end