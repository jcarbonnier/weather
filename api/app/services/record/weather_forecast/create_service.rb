module Record
  module WeatherForecast
    # Create a WeatherForecast
    class CreateService < BaseService
      step :init_options
      step :validate
      step :init_record
      step :create_record

      protected

      def validate(input)
        return Failure('missing attributes') if input[:attributes][:current_date].blank?
        return Failure('missing weather_location_id') if input[:attributes][:weather_location_id].blank?
        return Failure('missing date') if input[:attributes][:current_date].blank?

        Success(input)
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
