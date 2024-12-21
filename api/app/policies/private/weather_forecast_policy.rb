module Private
  # Private weather forecast policy
  class WeatherForecastPolicy < ApplicationPolicy
    # -------------------------
    # Authorizations
    def index?
      @user.is_a?(User)
    end

    def show?
      @user.is_a?(User)
    end

    # -------------------------
    # Strong parameters
    def permitted_params_for_index
      [
        filter: %w[id include weather_location_id current_date]
      ]
    end

    # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
    # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
    # In most cases the behavior will be identical, but if updating existing
    # code, beware of possible changes to the ancestors:
    # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5
    class Scope < ApplicationPolicy::Scope
      # NOTE: Be explicit about which records you allow access to!
      def resolve
        return scope.none unless @user.is_a?(User)

        scope.where(weather_location_id: @user.weather_location_ids)
      end
    end
  end
end
