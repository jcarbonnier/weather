class Api::Public::SessionsController < Api::Public::BaseController
  # rubocop:disable Metrics/AbcSize
  def create
    user = ::User.where(login: params[:user][:login]).first
    raise 'invalid user' if user.blank? || !user.authenticate(params[:user][:password])

    respond_with({ id: user.id, login: user.login, token: user.token }, location: nil)
  rescue StandardError => e
    respond_with(invalid_user(e.message))
  end
  # rubocop:enable Metrics/AbcSize

  protected

  def invalid_user(message)
    user = User.new
    user.errors.add(:base, message)
    user
  end
end
