# app/policies/active_admin/page_policy.rb
module ActiveAdmin
  class PagePolicy < ApplicationPolicy
    def show?
      case record.name
      when 'Dashboard'
        true
      else
        false
      end
    end
  end
end
