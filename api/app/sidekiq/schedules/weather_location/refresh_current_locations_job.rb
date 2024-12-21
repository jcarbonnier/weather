# Loop over all locations to refresh data
class Schedules::WeatherLocation::RefreshCurrentLocationsJob
  include Sidekiq::Job

  def perform
    ::WeatherLocation.find_each do |location|
      Record::WeatherLocation::RefreshCurrentJob.perform_async(location.id)
    end
  end
end
