# Current class allows you to keep all the per-request attributes easily available to the whole system
# See https://api.rubyonrails.org/classes/ActiveSupport/CurrentAttributes.html
class Current < ActiveSupport::CurrentAttributes
  attribute :user
  attribute :request_id, :request_method, :user_agent, :ip_address

  # Setup Current user or customer based on token data
  def setup_from_jwt(jwt_data)
    # Rails.logger.debug { "Setup from jwt: #{jwt_data.inspect}" }
    return if jwt_data.blank?

    self.user = User.find(jwt_data['id'])
  end
end
