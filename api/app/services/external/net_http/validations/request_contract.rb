module External
  module NetHttp
    module Validations
      # Request validations
      class RequestContract < ::TransactionService
        step :init_options
        step :validate

        def init_options(options)
          Rails.logger.debug { "Request contract options: #{options.inspect}" }
          Success(
            url:    options[:url],
            method: options[:method]
          )
        end

        def validate(attributes)
          return Failure('url is missing') if attributes[:url].blank?
          return Failure('url invalid') unless URI::DEFAULT_PARSER.make_regexp.match?(attributes[:url])
          return Failure('method is missing') if attributes[:method].blank?
          return Failure('method unknown') if %w[Get Patch Put Post Delete].exclude?(attributes[:method])

          Success(attributes)
        end
      end
    end
  end
end
