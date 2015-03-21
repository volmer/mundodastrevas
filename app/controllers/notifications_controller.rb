class NotificationsController < ApplicationController
  def index
    authorize(Notification.new)

    @notifications =
      current_user
      .notifications
      .order('unread DESC, created_at DESC')
      .page(params[:page])
  end

  def show
    @notification = Notification.find(params[:id])

    authorize(@notification)

    @notification.update_attribute(:unread, false)

    redirect_to Notifications.decorator_for(@notification).redirect_path
  end

  def read
    @notification = Notification.find(params[:notification_id])

    authorize(@notification)

    @notification.update_attribute(:unread, false)

    head :no_content
  end
end
