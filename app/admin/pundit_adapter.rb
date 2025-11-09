# app/admin/pundit_adapter.rb
module ActiveAdmin
  class PunditAdapter < AuthorizationAdapter
    def retrieve_policy(subject)
      policy = Pundit.policy!(user, subject)
      policy || default_policy(subject)
    rescue Pundit::NotDefinedError
      default_policy(subject)
    end

    private

    def default_policy(subject)
      Admin::DefaultPolicy.new(user, subject)
    end
  end
end
