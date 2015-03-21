module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters

    def update
      @user = User.find(current_user.id)
      unconfirmed_email = @user.unconfirmed_email

      if @user.update_attributes(account_update_params)
        if is_navigational_format?
          set_flash_message :notice, message_for_update(unconfirmed_email)
        end

        sign_in @user, bypass: true
        respond_with @user, location: @user
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
      devise_parameter_sanitizer.for(:sign_up) do |u|
        u.permit(:name, :email, :password, :password_confirmation)
      end

      devise_parameter_sanitizer.for(:account_update) do |u|
        u.permit(:name, :email, :gender, :bio, :location, :birthday, :avatar)
      end
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
  end
end
