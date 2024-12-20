require 'net/http'

module External
  module NetHttp
    # ANTS class to call external API get_status (check duplicated)
    # https://api-coordination.rendezvouspasseport.ants.gouv.fr/docs#/Application%20Ids%20-%20%C3%A9diteurs/get_status_api_status_get
    class Request < ::TransactionService
      step :init_options
      step :validate
      step :validate_headers
      step :assign_uri
      step :assign_default_headers
      step :perform
      step :handle_response

      protected

      # Init options
      def init_options(options)
        @attributes = options[:attributes]

        Success(@attributes)
      end

      # Validate required attributes
      def validate(attributes)
        result = Validations::RequestContract.call(attributes)
        return Failure(result.failure) if result.failure?

        Success(attributes)
      end

      # Validate headers
      def validate_headers(attributes)
        return Success(attributes) if attributes[:headers].blank?

        result = Validations::HeadersContract.call(attributes[:headers])
        return Failure(result.failure) if result.failure?

        Success(attributes)
      end

      # Assign URI object based on url and query_params attributes
      def assign_uri(attributes)
        input_url = attributes.delete(:url)
        attributes[:uri] = URI(input_url)
        # Adding query params to uri
        query_params = attributes.delete(:query_params) || {}
        attributes[:uri].query = URI.encode_www_form(query_params)

        Success(attributes)
      rescue StandardError => e
        Failure('bad_uri', e)
      end

      # Assign default headers
      def assign_default_headers(attributes)
        attributes[:headers] ||= {}
        attributes[:headers]['Accept'] ||= 'application/json'

        Success(attributes)
      end

      # Perform API call
      def perform(attributes)
        http_request  = build_http_request(attributes)
        http_client   = build_http_client(http_request, attributes)
        http_response = http_client.request(http_request)

        Success(http_response)
      rescue StandardError => e
        Failure('bad_request', e)
      end

      # Handle http response
      def handle_response(response)
        return Failure(response.body) unless status_succeeded?(response.code)

        Success(response.body)
      rescue StandardError => e
        Failure('bad_response', e)
      end

      private

      # Assign http request
      def build_http_request(attributes)
        net_http_class = http_request_class(attributes[:method])
        request = net_http_class.new(attributes[:uri], attributes[:headers])
        # Assign Post / Put / Patch form data to request
        request.set_form_data(attributes[:body_params]) if format_form_data?(attributes)
        request
      end

      # Build a Net::Http object
      def build_http_client(request, attributes)
        http_client = Net::HTTP.new(request.uri.host, request.uri.port)
        # Override max_retries (1 by default)
        http_client.max_retries = attributes[:max_retries] if attributes[:max_retries].present?
        # Setup SSL
        http_client_ssl_options(http_client, attributes, use_ssl: use_ssl?(request.uri))
        # Setup timeouts
        http_client_timeout_options(http_client, attributes)
      end

      # Setup ssl options for http client
      def http_client_ssl_options(http_client, attributes, use_ssl:)
        http_client.use_ssl = use_ssl
        http_client.verify_mode = attributes[:verify_mode] if use_ssl && attributes[:verify_mode].present?
        http_client
      end

      # Setup timeouts options for http client
      def http_client_timeout_options(http_client, attributes)
        # time to open the connection
        # Number of seconds to wait for the connection to open
        # default is nil, Ruby 2.3 to 60sec
        http_client.open_timeout = attributes[:open_timeout] if attributes[:open_timeout].present?
        # time to receive data after connected
        # Number of seconds to wait for one block to be read
        # default is 60
        http_client.read_timeout = attributes[:read_timeout] if attributes[:read_timeout].present?
        http_client
      end

      # Extract Net::HTTP request class based on method attribute
      def http_request_class(http_method)
        return Net::HTTP::Get     if http_method == 'Get'
        return Net::HTTP::Post    if http_method == 'Post'
        return Net::HTTP::Put     if http_method == 'Put'
        return Net::HTTP::Patch   if http_method == 'Patch'
        return Net::HTTP::Delete  if http_method == 'Delete'

        nil
      end

      # Check if data have to be sent in body
      def format_form_data?(attributes)
        return false unless %w[Post Put Patch].include?(attributes[:method])
        return false if attributes[:body_params].blank?

        true
      end

      # Check if using ssl
      def use_ssl?(uri)
        uri.port == 443
      end

      # Check if status is ok
      def status_succeeded?(status)
        status.to_i >= 200 && status.to_i < 300
      end
    end
  end
end
