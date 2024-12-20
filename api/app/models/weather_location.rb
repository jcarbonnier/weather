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
class WeatherLocation < ApplicationRecord
  # ----------------------------------------
  # RELATIONSHIPS
  # ----------------------------------------
  has_many :weather_forecasts, dependent: :destroy
  has_and_belongs_to_many :users

  # ----------------------------------------
  # SETUP
  # ----------------------------------------
  validates :name, presence: true
  validates :country, presence: true
  validates :lat, presence: true
  validates :lon, presence: true
end
