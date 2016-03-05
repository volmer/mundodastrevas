module NotificationsHelper
  def unread_notifications_count(user)
    user.notifications.where(unread: true).count
  end
end
