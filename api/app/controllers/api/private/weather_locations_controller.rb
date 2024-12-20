class Api::Private::WeatherLocationsController < Api::Private::BaseController
  protected

  def service_for_create
    Record::WeatherLocation::CreateService
  end

  def service_for_destroy
    Record::WeatherLocation::DestroyService
  end
end
