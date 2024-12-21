# Refresh current weather location
class Record::WeatherLocation::RefreshCurrentJob
  include Sidekiq::Job

  sidekiq_options retry: 0

  def perform(id)
    location = ::WeatherLocation.find(id)
    return false if location.blank?

    result = External::WeatherApi::ForecastService.call(q: "#{location.lat},#{location.lon}")
    return false if result.failure?

    result = refresh(result.success, location)
    return true if result.success?

    Rails.logger.error { "Refresh current location failed: #{result.failure}" }
    false
  end

  def refresh(json_response, location)
    forecast_attributes = External::WeatherApi::BaseService.forecast_to_attributes(json_response, location)
    forecast = ::WeatherForecast.where(weather_location_id: location.id, current_date: Time.zone.today).first
    return Record::WeatherForecast::CreateService.call(params: forecast_attributes) if forecast.blank?

    Record::WeatherForecast::UpdateService.call(params: forecast_attributes, record: forecast)
  end
end
