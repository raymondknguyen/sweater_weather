class Api::V1::BackgroundsController < ApplicationController
  def index
    picture = BackgroundService.new(params[:location].gsub(',',' '))
    render json: BackgroundSerializer.new(picture)
  end
end