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
          create_forecast!(input[:record])
        end
        Success(input[:record])
      rescue ActiveRecord::RecordInvalid
        Failure(input[:record])
      end

      private

      # Fetching forecast
      def create_forecast!(record)
        return true if forecast_already_exists?(record)

        result = External::WeatherApi::ForecastService.call(q: "#{record.lat},#{record.lon}")
        forecast_failure!(record, result.failure) if result.failure?

        forecast_attributes = External::WeatherApi::BaseService.forecast_to_attributes(result.success, record)
        result = Record::WeatherForecast::CreateService.call(params: forecast_attributes)
        forecast_failure!(record, result.failure) if result.failure?
      end

      # Check if forecast already exists in DB
      def forecast_already_exists?(record)
        ::WeatherForecast.exists?(weather_location_id: record.id, current_date: Time.zone.today)
      end

      # Raise exception to rollback transaction
      def forecast_failure!(record, message)
        record.errors.add(:weather_forecasts, message)
        raise ActiveRecord::Rollback
      end
    end
  end
end
