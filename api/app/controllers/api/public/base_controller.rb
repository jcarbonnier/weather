class Api::Public::BaseController < ApplicationController
  # No need to authenticate by default in public
  def skip_authentication?
    true
  end

  # --------------------------------------------------
  # PUNDIT OVERRIDES
  # --------------------------------------------------

  # Override pundit policy method
  def policy(klass)
    super([:public, klass])
  end

  # Override pundit policy_scope
  def policy_scope(scope)
    super([:public, scope])
  end

  # Override pundit authorize
  def authorize(record, query = nil)
    super([:public, record], query)
  end
end
