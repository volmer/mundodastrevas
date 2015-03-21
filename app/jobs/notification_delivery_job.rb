class NotificationDeliveryJob < ActiveJob::Base
  queue_as :default

  def perform(user, notifiable, event)
    notification = Notification.find_or_initialize_by(
      user:       user,
      event:      event,
      notifiable: notifiable
    )

    notification.send! if notification.new_record?

    notification
  end
end
