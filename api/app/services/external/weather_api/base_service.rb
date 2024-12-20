module External
  module WeatherApi
    # Weather api default base service
    class BaseService < ::TransactionService
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
