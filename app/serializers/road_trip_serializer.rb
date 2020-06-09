class RoadTripSerializer < ApplicationController
  include FastJsonapi::ObjectSerializer
  attributes :origin,
              :destination,
              :travel_time,
              :arrival_forecast
end