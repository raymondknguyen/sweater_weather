class Api::V1::RoadTripController < ApplicationController
  def create
    if User.find_by(api_key: params[:api_key])
      road_trip = RoadTripFacade.new(params[:origin], params[:destination])
      render json: RoadTripSerializer.new(road_trip), status: 200
    else 
      render json: { error: "Bad credentials. Please double check login request." }, status: 400
    end
  end
end