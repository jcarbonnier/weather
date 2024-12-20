module Record
  module WeatherForecast
    # Create a WeatherForecast
    class CreateService < BaseService
      step :init_options
      step :validate
      step :find_existing_forecast
      step :init_record
      step :create_record

      protected

      def validate(input)
        Rails.logger.debug { "Attributes valid? #{input[:attributes].inspect}" }
        return Failure('missing weather_location_id') if input[:attributes][:weather_location_id].blank?

        Success(input)
      end

      # STEP: find existing location in DB
      def find_existing_forecast(input)
        found = ::WeatherForecast.where(
          weather_location_id: input[:attributes][:weather_location_id],
          current_date:        Time.zone.today
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
        end
        Success(input[:record])
      rescue ActiveRecord::RecordInvalid
        Failure(input[:record])
      end
    end
  end
end
