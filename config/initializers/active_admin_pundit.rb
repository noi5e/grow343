# config/initializers/active_admin_pundit.rb
module ActiveAdmin
  class PunditAdapter
    # Override policy_scope to handle ActiveAdmin arrays
    def policy_scope(scope)
      normalized_scope = scope.is_a?(Array) ? scope.last : scope
      Rails.logger.debug "[Pundit Debug] Normalized scope: #{normalized_scope.inspect}"
      super(normalized_scope)
    end
  end
end
