class Api::Public::WeatherAveragesController < Api::Public::BaseController
  def index
    authorize current_model
    result = External::WeatherApi::AverageService.call(q: query_param_q)
    @resources = load_results(result)
    respond_with(@resources) do |format|
      format.jsonapi
      format.json
    end
  end

  protected

  def current_model
    WeatherAverage
  end

  def load_results(result)
    if result.failure?
      Rails.logger.debug { "Service failure: #{result.failure}" }
      return []
    end

    result.success
  end

  def query_param_q
    return nil if params[:filter].blank? || params[:filter][:q].blank?

    params[:filter][:q]
  end
end
