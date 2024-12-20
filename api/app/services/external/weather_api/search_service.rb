module External
  module WeatherApi
    # Get current weather
    class SearchService < BaseService
      step :init_options
      step :validate
      step :perform
      step :handle_response

      def init_options(options)
        Success(
          q: options[:q]
        )
      end

      def validate(input)
        return Failure('name is missing') if input[:q].blank?

        Success(input)
      end

      def perform(input)
        result = External::NetHttp::Request.call(
          attributes: search_request_attributes(input)
        )
        return Failure(result.failure) if result.failure?

        Success(result.success)
      end

      def handle_response(response_body)
        json_response = JSON.parse(response_body)

        Success(json_response)
      rescue StandardError => e
        Failure(e.message)
      end

      private

      def search_request_attributes(input)
        {
          method:       'Get',
          url:          "#{ENV.fetch('WEATHER_API_DOMAIN')}/v1/search.json",
          headers:      api_headers,
          query_params: api_query_params(input),
          max_retries:  0
        }
      end

      def api_query_params(input)
        super.merge(
          q: input[:q]
        )
      end
    end
  end
end
