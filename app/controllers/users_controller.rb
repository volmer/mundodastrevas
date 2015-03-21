class UsersController < ApplicationController
  def show
    @user = User.find_by_name!(params[:id])
    authorize(@user)

    @activities =
      @user.activities.where(privacy: 'public')
      .order(created_at: :desc).page(params[:page])
  end
end
