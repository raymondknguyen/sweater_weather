class WeatherSerializer
  include FastJsonapi::ObjectSerializer
  attributes :location,
              :current_time,
              :summary, 
              :temp, 
              :temp_high, 
              :temp_low, 
              :feels_like, 
              :humidity,
              :visibility,
              :uv_index,
              :sunrise,
              :sunset,
              :hourly_forecast,
              :daily_forecast
end
