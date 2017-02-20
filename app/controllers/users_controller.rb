class UsersController < ApplicationController
  def show
    @user = User.find_using_nme!(params[:id])
    authorize(@user)

    @zines = @user.zines.order(updated_at: :desc)
  end
end
