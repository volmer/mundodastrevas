class RankNotificationJob < ActiveJob::Base
  def perform(user, rank)
    notification = Notification.find_or_initialize_by(
      user:       user,
      event:      'new_rank',
      notifiable: rank
    )

    notification.send! if notification.new_record?

    notification
  end
end
