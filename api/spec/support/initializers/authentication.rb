# frozen_string_literal: true

# == Authentication related helpers
module AuthenticatedApiHelpers
  # == Return the current user or customer calling the API
  #
  # @return {User} || {Customer}
  def current_user
    Current.user || store_current_user
  end

  # == Stores the user calling the API
  #
  # Take a test sample "user" or create one
  def store_current_user(user = nil)
    user ||= create(:user)
    Current.user = user
  end

  # # == Stores the customer calling the API
  # #
  # # Take a test sample "customer" or create one
  # def store_current_customer
  #   customer ||= create(:customer, companies: [company])
  #   Current.customer_id = customer.id
  #   Current.customer
  # end

  # == Return the headers to use for API authentication
  #
  # @param {User} user: The user to authenticate
  #
  # @return {Hash} containing the headers to send
  def headers_with_auth(user = current_user)
    # access_token = create(:access_token, resource_owner_id: user.id).token
    { 'Authorization' => "Bearer #{user.token}" }
  end

  # == Send a request with authentication headers and tenant param
  #
  # @param {Symbol} method: The HTTP method to use
  # @param {String} path: The path of the endpoint to request
  # @param {Hash} :params: Parameters to send along the request
  # @param {Hash} :headers: Additional headers for the request
  def with_auth(method, path, params: {}, headers: {})
    final_headers = headers_with_auth.merge(headers.to_h)

    public_send method, path, params: params, headers: final_headers
  end

  # == Generate authenticated request methods  for each HTTP method
  #
  # def get_with_auth(*args, **kargs)
  #   with_auth :get, *args, **kargs
  # end
  %i[get post put patch delete].each do |http_method|
    define_method :"#{http_method}_with_auth" do |*args, **kargs|
      with_auth http_method, *args, **kargs
    end
  end
end

RSpec.configure do |config|
  # Including the helpers only for specs of type `request` (located in `spec/requests`).
  config.include AuthenticatedApiHelpers, type: :request

  # Create the user calling the API before each `request` spec unless the `:skip_api_user` metadata
  # is provided.
  #
  # Example:
  #   it "is some authenticated request spec" do
  #     # api_user is a User here
  #   end
  #
  #   it "is some unauthenticated request spec", :skip_api_user do
  #     # api_user is empty here
  #   end
  config.before :each, type: :request do |example|
    host! ENV.fetch('DOMAIN') || 'localhost'
    store_current_user unless example.metadata[:skip_api_user]
    # store_current_customer  if     example.metadata[:skip_api_user]
  end
  config.after :each, type: :request do |_example|
    User.delete_all
    Current.user = nil
  end
end
