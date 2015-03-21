module NotificationsHelper
  def unread_notifications_count(user)
    user.notifications.where(unread: true).count
  end

  def last_notifications(user)
    user.notifications.order('unread DESC, created_at DESC').limit(4)
  end

  def link_to_notification(notification)
    text = Notifications.decorator_for(notification).text

    unread_class = notification.unread ? 'unread' : 'read'

    link_to(
      text,
      notification,
      class: "notification #{ unread_class }",
      data: { id: notification.id }
    )
  end
end
