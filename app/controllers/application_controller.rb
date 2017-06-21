class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def access_denied(exception)
    redirect_to :admin_root, alert: exception.message
  end

end
