module Record
  module WeatherLocation
    # Create a WeatherLocation
    class CreateService < BaseService
      step :init_options
      step :find_existing_location
      step :init_record
      step :create_record

      protected

      # STEP: find existing location in DB
      def find_existing_location(input)
        found = ::WeatherLocation.where(
          lat: input[:attributes][:lat],
          lon: input[:attributes][:lon]
        ).first
        Success(input) unless found

        input[:record] = found
        Success(input)
      end

      # STEP: init_record (skip if already found)
      def init_record(input)
        return Success(input) if input[:record].present?

        super
      end

      # STEP: Create record
      def create_record(input)
        ActiveRecord::Base.transaction do
          input[:record].save!
          input[:record].users << Current.user
          fetch_forecast!(input[:record])
        end
        Success(input[:record])
      rescue ActiveRecord::RecordInvalid
        Failure(input[:record])
      end

      private

      # Fetching forecast
      def fetch_forecast!(record)
        result = External::WeatherApi::ForecastService.call(q: "#{record.lat},#{record.lon}")
        forecast_failure!(record, result.failure) if result.failure?

        forecast_attributes = format_forecast_attributes(result.success, record)
        result = Record::WeatherForecast::CreateService.call(params: forecast_attributes)
        Rails.logger.debug { "Forecast result: #{result.inspect}" }

        forecast_failure!(record, result.failure) if result.failure?
      end

      # Format forecast json response
      def format_forecast_attributes(json_response, record)
        { current_date:        Time.zone.today,
          current:             json_response['current'],
          forecast:            json_response['forecast'],
          weather_location_id: record.id }
      end

      # Raise exception to rollback transaction
      def forecast_failure!(record, message)
        record.errors.add(:weather_forecasts, message)
        raise ActiveRecord::Rollback
      end
    end
  end
end
