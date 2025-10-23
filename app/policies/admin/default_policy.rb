# app/policies/admin/default_policy.rb
module Admin
  class DefaultPolicy < ApplicationPolicy
    class Scope
      attr_reader :user, :scope

      def initialize(user, scope)
        @user = user
        @scope = scope
      end

      def resolve
        scope.all  # or filter as needed
      end
    end

    def index?; true; end
    def show?; true; end
    def create?; true; end
    def update?; true; end
    def destroy?; true; end
  end
end
