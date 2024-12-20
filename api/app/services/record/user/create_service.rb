module Record
  module User
    # Create a user
    class CreateService < BaseService
      step :init_options
      step :init_record
      step :create_record

      protected

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
