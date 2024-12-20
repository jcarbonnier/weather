# Base transaction service class
class TransactionService
  # Success / Failure management
  include Dry::Transaction

  # ========================================
  # Class methods
  # ========================================
  class << self
    # Directly run Service.call without instantiation
    def call(args = {}, &block)
      new.call(args, &block)
    end
  end
end
