module External
  module NetHttp
    module Validations
      # Headers validations
      class HeadersContract < ::TransactionService
        step :init_options
        step :validate

        def init_options(options)
          Success(
            'Content-Type': options[:'Content-Type'],
            Accept:         options[:Accept],
            Authorization:  options[:Authorization]
          )
        end

        def validate(attributes)
          return Failure('unkown Accept header') if accepted_formats.exclude?(attributes[:Accept])

          Success(attributes)
        end

        private

        def accepted_formats
          %w[application/json application/vnd.api+json]
        end
      end
    end
  end
end
