class Api::Private::BaseController < ApplicationController
  # Force authentication for private routes
  def skip_authentication?
    false
  end

  # --------------------------------------------------
  # PUNDIT OVERRIDES
  # --------------------------------------------------

  # Override pundit policy method
  def policy(klass)
    super([:private, klass])
  end

  # Override pundit policy_scope
  def policy_scope(scope)
    super([:private, scope])
  end

  # Override pundit authorize
  def authorize(record, query = nil)
    super([:private, record], query)
  end
end
