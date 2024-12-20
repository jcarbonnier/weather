module Record
  # Base service class for records services classes
  class BaseService < TransactionService
    # ========================================
    # Common steps
    # ========================================

    # Step: init options, first step to call
    def init_options(options)
      Success({ record:     options[:record] || nil,
                attributes: options[:params].to_h.deep_symbolize_keys })
    end

    def init_record(input)
      input[:record] = record_model.new(input[:attributes])
      Success(input)
    end

    def assign_attributes(input)
      input[:record].assign_attributes(input[:attributes])
      Success(input)
    end

    protected

    # STEP: Cleanup name received from query params
    def cleanup_name(input)
      input[:name] = input[:name].squish if input[:name].present?
      input
    end

    # STEP: Assess url name from query params name
    def assess_url_from_name(input)
      url_name = input[:attributes][:name].try(:parameterize)
      input[:attributes][:url_name] = url_name
      input
    end
  end
end
