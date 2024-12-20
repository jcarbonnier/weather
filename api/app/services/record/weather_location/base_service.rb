module Record
  module WeatherLocation
    # BaseService for WeatherLocation
    #
    # Define here common service methods
    class BaseService < Record::BaseService
      # protected

      # Record model class
      def record_model
        ::WeatherLocation
      end
    end
  end
end
