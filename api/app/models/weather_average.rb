# Compute locations average temperatures
class WeatherAverage
  # ----------------------------------------
  # ActiveModel includes
  # ----------------------------------------
  include ActiveModel::Model
  include ActiveModel::Serialization

  # ----------------------------------------
  # ATTRIBUTES
  # ----------------------------------------
  attr_accessor :name, :date, :average
end
