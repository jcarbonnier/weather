class ApplicationController < ActionController::API
  # ==================================================
  # CONCERNS
  # ==================================================
  # Manage app authentication
  include AuthenticationConcern
  # Manage app authorizations
  include Pundit::Authorization
  # Manage request params
  include ParamsConcern

  # ==================================================
  # RESPONDERS
  # ==================================================
  respond_to :json, :jsonapi

  # ==================================================
  # APP EXCEPTIONS
  # ==================================================
  # Missing required parameters
  # => BAD_REQUEST response status 400
  rescue_from ActionController::ParameterMissing do |e|
    Rails.logger.error "ActionController::ParameterMissing error: #{e.message}"
    head :bad_request
  end

  # Not authorized error
  # => FORBIDDEN response status 403
  rescue_from Pundit::NotAuthorizedError do |e|
    Rails.logger.error "Pundit::NotAuthorizedError error: #{e.message}"
    head :forbidden
  end

  # Record not found
  # => NOT_FOUND response status 404
  rescue_from ActiveRecord::RecordNotFound do |e|
    Rails.logger.error "ActionController::RecordNotFound error: #{e.message}"
    head :not_found
  end

  # Unprocessable entity
  # => UNPROCESSABLE_ENTITY response status 422
  rescue_from ActiveRecord::RecordInvalid do |e|
    respond_with e.record, status: :unprocessable_entity
  end

  # ==================================================
  # METHODS
  # ==================================================

  ##
  # GET collection of records
  #
  # Check Pundit authorizations:
  #   - authorize the current_model
  #   - extract permitted params
  #   - DB request the scoped records
  #
  # Finaly, format the HTTP response paginated when needed
  #
  # @param HttpQueryParams : request query params
  # @return HttpResponse : http response formatted
  def index
    authorize current_model
    permitted_params = params_for_index
    @resources ||= policy_scope(current_model).db_search(permitted_params[:filter])
    respond_with(@resources,
                 include: params[:include] || []) do |format|
      format.jsonapi
      format.json
    end
  end

  ##
  # GET record
  #
  # Check Pundit authorizations:
  #   - authorize the current_model
  #   - DB request the scoped record
  #   - authorize resource
  #
  # Finaly, format the HTTP response
  #
  # @param HttpQueryParams : request query params
  # @return HttpResponse : http response formatted
  def show
    authorize current_model
    @resource ||= policy_scope(current_model).find(params[:id])
    authorize @resource
    respond_with(@resource, include: params[:include] || [])
  end

  ##
  # POST record
  #
  # Check Pundit authorizations:
  #   - authorize the current_model
  #
  # Call the create service associated to the current_model that manage INSERT in DB
  #
  # Finaly, format the HTTP response
  #
  # @param HttpQueryParams : request query params
  # @return HttpResponse : http response formatted
  def create
    authorize current_model
    result = service_for_create.call(params: params_for_create)
    service_write_failure(result.failure) if result.failure?

    @resource = result.success
    respond_with @resource, location: nil
  end

  ##
  # PUT / PATCH record
  #
  # Check Pundit authorizations:
  #   - authorize the current_model
  #   - DB request the scoped record
  #   - authorize resource
  #
  # Call the create service associated to the current_model that manage INSERT in DB
  #
  # Finaly, format the HTTP response
  #
  # @param HttpQueryParams : request query params
  # @return HttpResponse : http response formatted
  def update
    authorize current_model
    @resource ||= policy_scope(current_model).find(params[:id])
    authorize @resource
    result = service_for_update.call(record: @resource, params: params_for_update)
    service_write_failure(result.failure) if result.failure?

    respond_with @resource, head: 200
  end

  ##
  # DELETE record
  #
  # Check Pundit authorizations:
  #   - authorize the current_model
  #   - DB request the scoped record
  #   - authorize resource
  #
  # Call the destroy service associated to the current_model that manage DELETE in DB
  #
  # Finaly, format the HTTP response
  #
  # @param HttpQueryParams : request query params
  # @return HttpResponse : http response formatted
  def destroy
    authorize current_model
    @resource ||= policy_scope(current_model).find(params[:id])
    authorize @resource
    result = service_for_destroy.call(record: @resource)
    return respond_with :deleted if result.success?

    respond_with @resource, location: nil
  end

  # ==================================================
  # PROTECTED METHODS
  # ==================================================
  # protected

  # ==================================================
  # PRIVATE METHODS
  # ==================================================
  private

  # Current model class
  def current_model
    resource_name.constantize
  end

  # Resource name based on controller
  def resource_name
    controller_name.classify
  end

  def service_write_failure(record)
    raise ActiveRecord::RecordInvalid.new(record), 'service_write_failure error'
  end
end
