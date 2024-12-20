module Record
  module User
    # BaseService for user
    #
    # Define here common service methods
    class BaseService < Record::BaseService
      # protected

      # Record model class
      def record_model
        ::User
      end
    end
  end
end
