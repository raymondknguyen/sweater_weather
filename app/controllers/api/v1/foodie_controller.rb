class Api::V1::FoodieController < ApplicationController
  def index
    foodie = FoodieFacade.new(params[:start] , params[:end], params[:search])
    render json: FoodieSerializer.new(foodie)
  end
end