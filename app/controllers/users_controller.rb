class UsersController < ApplicationController
  def show
    @user = User.find_by_name!(params[:id])
    authorize(@user)

    @activities =
      @user.activities.where(privacy: 'public').includes(:subject).order(
        created_at: :desc).page(params[:page])

    @zines = @user.zines.order(updated_at: :desc)
  end
end
