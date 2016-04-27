class Notification < ActiveRecord::Base
  EVENTS = %w(
    new_comment
    new_forum_post
    new_message
    new_rank
  ).freeze

  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  validates :event,
            presence: true,
            inclusion: { in: EVENTS }
  validates :user_id, presence: true
  validates :notifiable_id, presence: true

  default_scope { where.not(event: 'new_follower') }

  def send!
    save!
    return if user.email_preferences.try(:[], event) == 'false'
    NotificationMailer.notify(self).deliver_now
  end
end
