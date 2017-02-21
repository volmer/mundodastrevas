class UsersController < ApplicationController
  skip_after_action :verify_authorized

  def show
    @zines = current_user.zines.order(updated_at: :desc)
  end
end
