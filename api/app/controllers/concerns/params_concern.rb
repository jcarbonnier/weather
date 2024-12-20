# Manage request strong parameters
# Check required and permitted parameters for controller actions based on policies
module ParamsConcern
  extend ActiveSupport::Concern

  # Check INDEX parameters (filtering params)
  def params_for_index
    params.permit(policy(current_model).permitted_params_for_index)
  end

  # Check CREATE parameters and deserialize if needed
  def params_for_create
    permit_write_params(policy(current_model).permitted_params_for_create)
  end

  # Check UPDATE parameters and deserialize if needed
  def params_for_update
    permit_write_params(policy(current_model).permitted_params_for_update)
  end

  protected

  # Permit params based on request format
  def permit_write_params(only)
    parameters = require_write_params
    return parameters.permit(only) if request.format.json?

    # Default: jsonapi
    ActiveModelSerializers::Deserialization.jsonapi_parse(
      params,
      only: only
    )
  end

  # Require params based on request format
  def require_write_params
    # json format: need table name prefix in params
    return params.require(current_model.table_name) if request.format.json?

    # jsonapi format: need data prefix with type and attributes params
    params.require(:data).require(%i[type attributes]).last
  end
end
