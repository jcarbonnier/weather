# == Schema Information
#
# Table name: weather_forecasts
#
#  id                  :bigint           not null, primary key
#  current             :json
#  current_date        :date
#  forecast            :json
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  weather_location_id :integer
#
# Indexes
#
#  index_location_and_date  (weather_location_id,current_date)
#
class WeatherForecastSerializer < ActiveModel::Serializer
  attributes :id, :current_date, :current, :forecast
  belongs_to :weather_location
end
