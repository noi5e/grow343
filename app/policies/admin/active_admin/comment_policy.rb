# app/policies/admin/active_admin/comment_policy.rb
module Admin
  module ActiveAdmin
    class CommentPolicy < ApplicationPolicy
      # Anyone who can access ActiveAdmin can see comments
      def show?
        true
      end

      def create?
        true
      end

      def update?
        true
      end

      def destroy?
        true
      end

      class Scope < Scope
        def resolve
          # Return all comments; you can restrict this if needed
          scope.all
        end
      end
    end
  end
end
