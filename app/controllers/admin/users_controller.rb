module Admin
  class UsersController < ApplicationController
    def index
      authorize(self)
      @users = User.order('name ASC').page(params[:page])
    end

    def show
      @user = User.find_by_name!(params[:id])
      authorize(self)
    end

    def update
      @user = User.find_by_name!(params[:id])
      authorize(self)

      if @user.update_attributes(user_params)
        redirect_to [:admin, @user],
                    notice: t('flash.admin.users.update', user: @user)
      else
        render 'show'
      end
    end

    def self.policy_class
      Admin::UserPolicy
    end

    private

    def user_params
      params.require(:user).permit(:state, role_ids: [])
    end
  end
end
