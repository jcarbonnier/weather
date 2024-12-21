module Record
  module WeatherForecast
    # BaseService for WeatherForecast
    #
    # Define here common service methods
    class BaseService < Record::BaseService
      # ---------------------------------------------
      # Instance methods
      # ---------------------------------------------
      # Record model class
      def record_model
        ::WeatherForecast
      end
    end
  end
end
