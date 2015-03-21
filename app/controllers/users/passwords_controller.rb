module Users
  class PasswordsController < Devise::PasswordsController
    prepend_before_filter :require_no_authentication,
                          except: [:change, :do_change]

    def change
      @user = current_user
    end

    def do_change
      @user = current_user

      user_params = params.required(:user).permit(
        :password, :current_password, :password_confirmation
      )

      if @user.update_with_password(user_params)
        sign_in @user, bypass: true
        redirect_to root_path, notice: t('flash.users.passwords.do_change')
      else
        render 'change'
      end
    end
  end
end
