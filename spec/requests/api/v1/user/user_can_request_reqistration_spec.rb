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

  it 'cant log in if email taken' do
    user_params = {
      email: 'email@email.com',
      password: 'password',
      password_confirmation: 'password'
    }
    User.create(user_params)

    user_params = {
      email: 'email1@email.com',
      password: 'password1',
      password_confirmation: 'password1'
    }

    email = 'email@email.com'
    password = 'password'

    post "/api/v1/users?email=#{email}&password=#{password}&password_confirmation=#{password}"

    expect(response).to_not be_successful
    data = JSON.parse(response.body , symbolize_names: true)
    expect(data[:errors].first).to eq("Email has already been taken")
    expect(response.status).to eq(400)
  end

  it 'cant log in if missing field' do
    email = 'emai3@email.com'
    password = ''

    post "/api/v1/users?email=#{email}&password=#{password}&password_confirmation=#{password}"

    expect(response).to_not be_successful
    data = JSON.parse(response.body , symbolize_names: true)
    expect(data[:errors].first).to eq("Password can't be blank")
    expect(response.status).to eq(400)
  end

  it 'cant log in if missing field' do
    email = 'emai3@email.com'
    password = 'password'
    not_same = 'notsame'
 
    post "/api/v1/users?email=#{email}&password=#{password}&password_confirmation=#{not_same}"

    expect(response).to_not be_successful
    data = JSON.parse(response.body , symbolize_names: true)
    expect(data[:errors].first).to eq("Password confirmation doesn't match Password")
    expect(response.status).to eq(400)
  end
end