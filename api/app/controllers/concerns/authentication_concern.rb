# Manage authentication
module AuthenticationConcern
  extend ActiveSupport::Concern

  included do
    # ==================================================
    # ACTIONS HOOKS
    # ==================================================
    # Authenticate user
    before_action :authenticate_user_from_token!
    # Authentication check
    before_action :authenticate_user!
  end

  def current_user
    Current.user
  end

  protected

  # Needs authentication by default
  # Override this method when you want to skip authentication
  def skip_authentication?
    false
  end

  private

  # ==================================================
  # Authentication methods
  # ==================================================
  def authenticate_user_from_token!
    # return true if skip_authentication?
    return false if request_token.blank?

    # Decode token to check validity
    decoded_token = JWT.decode(request_token.gsub('Bearer ', ''), ENV.fetch('SECRET_KEY_BASE'), true,
                               { algorithm: 'HS256' })

    # Authenticated with token
    Current.setup_from_jwt(decoded_token.first)
  rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
    head :unauthorized
  end

  def authenticate_user!(_options = {})
    return true if skip_authentication?

    head :unauthorized unless signed_in?
  end

  def signed_in?
    current_user.present?
  end

  def request_token
    @request_token ||= request.headers['Authorization'] || params['token']
  end
end
