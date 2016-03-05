class NotificationsController < ApplicationController
  def index
    authorize(Notification.new)

    @notifications =
      current_user
      .notifications
      .order(unread: :desc, created_at: :desc)
      .page(params[:page])
  end

  def show
    @notification = Notification.find(params[:id])
    authorize(@notification)
    @notification.update_attribute(:unread, false)

    redirect_to Notifications.decorator_for(@notification).redirect_path
  end
end
