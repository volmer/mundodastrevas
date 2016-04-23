module Users
  class SessionsController < Devise::SessionsController
    before_action :configure_permitted_parameters

    private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:login) }
    end
  end
end
