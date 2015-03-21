class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Pundit

  after_action :verify_authorized, unless: :devise_controller?

  rescue_from Pundit::NotAuthorizedError do
    if user_signed_in?
      self.response_body = nil

      redirect_to root_path, alert: t('flash.unauthorized')
    else
      authenticate_user!
    end
  end
end
