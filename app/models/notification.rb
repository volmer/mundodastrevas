class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  validates :event,
            presence: true,
            inclusion: { in: Notifications.events }
  validates :user_id, presence: true
  validates :notifiable_id, presence: true

  default_scope { where.not(event: 'new_follower') }

  def send!
    save!
    return if user.email_preferences.try(:[], event) == 'false'
    NotificationMailer.notify(self).deliver_now
  end
end
