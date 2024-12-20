module Record
  module WeatherLocation
    # Destroy a WeatherLocation
    class DestroyService < BaseService
      step :init_options
      step :destroy_record

      protected

      # STEP: Create record
      def destroy_record(input)
        ActiveRecord::Base.transaction do
          input[:record].destroy!
        end
        Success(input[:record])
      rescue ActiveRecord::RecordInvalid
        Failure(input[:record])
      end
    end
  end
end
