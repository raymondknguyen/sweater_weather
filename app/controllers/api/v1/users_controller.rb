class Api::V1::UsersController < ApplicationController
  def new
  end

  def create 
    user = User.create(user_params)
    user.save

    render json: UserSerializer.new(user)
  end

  private
  
  def user_params
     params.permit(:email, :password, :password_confirmation)
  end
end