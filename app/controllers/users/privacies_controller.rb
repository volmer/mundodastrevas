module  Users
  class PrivaciesController < ApplicationController
    skip_after_action :verify_authorized

    def edit
      @user = current_user
      @user.privacy ||= {}
    end

    def update
      @user = current_user
      @user.privacy ||= {}

      @user.update_attributes(privacy_params)

      redirect_to edit_user_privacy_path, notice: t(
        'flash.users.privacies.update'
      )
    end

    private

    def privacy_params
      params.require(:user).permit(privacy: @user.privacy_keys)
    end
  end
end
