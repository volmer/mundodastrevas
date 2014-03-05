class RankNotificationWorker
  include Sidekiq::Worker

  def perform(user_id, rank_id)
    user = Raddar::User.find(user_id)
    rank = Rank.find(rank_id)

    notification = Raddar::Notification.find_or_initialize_by(
      user:       user,
      event:      'new_rank',
      notifiable: rank
    )

    notification.send! if notification.new_record?

    notification
  end
end
