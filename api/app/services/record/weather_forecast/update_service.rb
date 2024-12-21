module Record
  module WeatherForecast
    # Update a WeatherForecast
    class UpdateService < BaseService
      step :init_options
      step :validate
      step :assign_attributes
      step :update_record

      protected

      def validate(input)
        return Failure('missing record') if input[:record].blank?
        return Failure('missing attributes') if input[:attributes].blank?

        Success(input)
      end

      # STEP: Update record
      def update_record(input)
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
