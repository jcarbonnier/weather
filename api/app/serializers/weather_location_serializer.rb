# == Schema Information
#
# Table name: weather_locations
#
#  id         :bigint           not null, primary key
#  country    :string
#  lat        :decimal(, )
#  lon        :decimal(, )
#  name       :string
#  region     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_lat_lon                    (lat,lon)
#  index_weather_locations_on_name  (name)
#
class WeatherLocationSerializer < ActiveModel::Serializer
  attributes :id, :name, :region, :country, :lat, :lon
  has_many :users
  has_many :weather_forecasts
end
