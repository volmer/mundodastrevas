module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      complete('facebook')
    end

    private

    def complete(provider)
      @provider = provider

      @user = OmniauthCompletion.complete(
        request.env['omniauth.auth'], current_user
      )

      if @user.persisted?
        redirect_persisted_user
      else
        redirect_unpersisted_user
      end
    end

    def redirect_persisted_user
      if is_navigational_format?
        set_flash_message(:notice, :success, kind: @provider.titleize)
      end

      if user_signed_in?
        logger.info 'User already signed in.'
        redirect_to user_external_accounts_path
      else
        logger.info 'User successfully registered. Signing in...'
        sign_in_and_redirect @user, event: :authentication
      end
    end

    def redirect_unpersisted_user
      logger.info "User could not be registered: #{@user.errors.inspect}"
      session['devise.omniauth_data'] = request.env['omniauth.auth']

      redirect_to new_user_registration_url
    end
  end
end
