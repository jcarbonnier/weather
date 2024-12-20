class Api::Private::LocationsController < Api::Private::BaseController
  def index
    authorize current_model
    result = External::WeatherApi::SearchService.call(q: query_param_name)
    @resources = load_results(result)
    respond_with(@resources) do |format|
      format.jsonapi
      format.json
    end
  end

  protected

  def current_model
    WeatherLocation
  end

  def load_results(result)
    if result.failure?
      Rails.logger.debug { "Service failure: #{result.failure}" }
      return []
    end

    result.success.map do |location|
      current_model.new(
        location.select { |k, _v| filtered_location_attributes.include?(k) }
        .with_indifferent_access
      )
    end
  end

  def query_param_name
    return nil if params[:filter].blank? || params[:filter][:name].blank?

    params[:filter][:name]
  end

  def filtered_location_attributes
    @filtered_location_attributes ||= %w[id name region country lat lon]
  end
end
