class UsersController < ApplicationController
  def show
    @user = User.find_by_name!(params[:id])
    authorize(@user)

    @zines = @user.zines.order(updated_at: :desc)
  end
end
