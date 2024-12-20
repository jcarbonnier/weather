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
FactoryBot.define do
  factory :weather_location do
    sequence(:name) { |n| "location-#{n}" }
    region { 'Ile de France' }
    country { 'France' }
    lat { '9.99' }
    lon { '9.99' }
    association :users
  end
end
