module Users
  class EmailPreferencesController < ApplicationController
    skip_after_action :verify_authorized

    def edit
      @user = current_user
      @user.email_preferences ||= {}
    end

    def update
      @user = current_user

      @user.update_attributes(email_preferences_params)

      redirect_to edit_user_email_preferences_path,
                  notice: t('flash.users.email_preferences.update')
    end

    private

    def email_preferences_params
      params.require(:user).permit(
        email_preferences: User.email_preferences_keys
      )
    end
  end
end
