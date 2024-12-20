module External
  module WeatherApi
    # Get current weather
    class AverageService < BaseService
      step :init_options
      step :validate
      step :load_locations
      step :load_forecasts
      step :format_averages

      def init_options(options)
        Success(
          q:    options[:q],
          lang: options[:lang] || 'fr'
        )
      end

      def validate(input)
        return Failure('q parameter is missing') if input[:q].blank?

        Success(input)
      end

      def load_locations(input)
        locations = query_locations(input)
        return Failure('empty locations') if locations.blank?

        input[:locations] = locations
        Success(input)
      end

      def load_forecasts(input)
        forecasts = query_forecasts(input[:locations])
        return Failure('empty forecasts') if forecasts.blank?

        input[:forecasts] = forecasts
        Success(input)
      end

      def format_averages(input)
        averages = input[:forecasts].map { |forecast| format_forecast(forecast) }
        Success(averages)
      end

      private

      def query_locations(input)
        [].tap do |locations|
          input[:q].split(',').each do |name|
            # Rails.logger.debug { "Query location for #{name}" }
            result = SearchService.call(q: name)
            if result.failure? || result.success.blank?
              Rails.logger.debug { "Location not found: #{name}" }
              next
            end

            # Many results, just keep the first one to prevent too much weather api calls
            locations << result.success.first
          end
        end
      end

      def query_forecasts(locations)
        [].tap do |forecasts|
          locations.each do |location|
            # Rails.logger.debug { "Query forecast for #{location.inspect}" }
            result = ForecastService.call(q: "#{location['lat']},#{location['lon']}")
            if result.failure
              Rails.logger.debug { "Location not found: #{name}" }
              next
            end
            forecasts << result.success
          end
        end
      end

      def format_forecast(forecast)
        ::WeatherAverage.new(
          name:    forecast['location']['name'],
          date:    forecast_date(forecast),
          average: forecast_average(forecast)
        )
      end

      def forecast_date(forecast)
        return nil if forecast['forecast'].blank? || forecast['forecast']['forecastday'].blank?

        current_day = forecast['forecast']['forecastday'].first
        return nil if current_day.blank?

        current_day['date']
      end

      def forecast_average(forecast)
        return 0 if forecast['forecast'].blank? || forecast['forecast']['forecastday'].blank?

        current_day = forecast['forecast']['forecastday'].first
        return 0 if current_day.blank?
        return 0 if current_day['day'].blank?

        current_day['day']['avgtemp_c']
      end
    end
  end
end
