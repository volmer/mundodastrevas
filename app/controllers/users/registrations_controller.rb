module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters

    def update
      @user = User.find(current_user.id)
      unconfirmed_email = @user.unconfirmed_email

      if @user.update_attributes(account_update_params)
        respond_to_update(unconfirmed_email)
      else
        clean_up_passwords @user
        respond_with @user
      end
    end

    def destroy
      @user = current_user

      return if request.request_method_symbol != :delete

      if @user.valid_password?(params[:user][:password])
        super
      else
        set_password_error
      end
    end

    private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(
        :sign_up, keys: [:name, :email, :password])

      devise_parameter_sanitizer.permit(
        :account_update,
        keys: [:name, :email, :gender, :bio, :location, :birthday, :avatar]
      )
    end

    def message_for_update(unconfirmed_email)
      if update_needs_confirmation?(@user, unconfirmed_email)
        :update_needs_confirmation
      else
        :updated
      end
    end

    def set_password_error
      @user.valid?
      @user.errors.add(
        :password, params[:user][:password].blank? ? :blank : :invalid
      )
      clean_up_passwords @user
    end

    def respond_to_update(unconfirmed_email)
      if is_navigational_format?
        set_flash_message :notice, message_for_update(unconfirmed_email)
      end

      sign_in @user, bypass: true
      respond_with @user, location: @user
    end
  end
end
