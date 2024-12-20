# Weather average serializer
class WeatherAverageSerializer < ActiveModel::Serializer
  attributes :id, :name, :date, :average

  def id
    SecureRandom.uuid
  end
end
