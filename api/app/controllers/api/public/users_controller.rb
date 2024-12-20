class Api::Public::UsersController < Api::Public::BaseController
  protected

  def service_for_create
    Record::User::CreateService
  end
end
