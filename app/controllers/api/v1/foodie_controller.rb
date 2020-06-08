class Api::V1::FoodieController < ApplicationController
  def index
  start = params[:start] 
  des = params[:end]
  search = params[:search]

  foodie = FoodieFacade.new(start, des, search)
  
  end
end