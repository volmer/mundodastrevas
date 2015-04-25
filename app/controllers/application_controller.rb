class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception
  after_action :verify_authorized, unless: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    if user_signed_in?
      self.response_body = nil
      redirect_to root_path, alert: t('flash.unauthorized')
    else
      authenticate_user!
    end
  end
end
