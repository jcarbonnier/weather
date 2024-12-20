module Private
  # Private weather location policy
  class WeatherLocationPolicy < ApplicationPolicy
    # -------------------------
    # Authorizations
    def index?
      @user.is_a?(User)
    end

    def show?
      @user.is_a?(User)
    end

    def create?
      @user.is_a?(User)
    end

    def destroy?
      @user.is_a?(User)
    end

    # -------------------------
    # Strong parameters
    def permitted_params_for_index
      [
        filter: %w[name]
      ]
    end

    def permitted_params_for_create
      %w[name region country lat lon]
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

        scope.joins(:users).where(users: { id: @user.id })
      end
    end
  end
end
