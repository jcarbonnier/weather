module External
  module WeatherApi
    # Weather api default base service
    class BaseService < ::TransactionService
      # ---------------------------------------------
      # Class methods
      # ---------------------------------------------
      def self.forecast_to_attributes(json_response, location)
        { current_date:        Time.zone.today,
          current:             json_response['current'],
          forecast:            json_response['forecast'],
          weather_location_id: location.id }
      end

      # Default api headers
      def api_headers
        {}
      end

      # Default api query params
      def api_query_params(_attributes)
        {
          key: ENV.fetch('WEATHER_API_KEY')
        }
      end
    end
  end
end
