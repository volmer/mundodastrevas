class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  validates :event,
            presence: true,
            inclusion: { in: lambda do |_|
              Notifications.decorators_mapping.keys.map(&:to_s)
            end }
  validates :user_id, presence: true
  validates :notifiable_id, presence: true

  def send!
    save!
    return if user.email_preferences.try(:[], event) == 'false'
    NotificationMailer.notify(self).deliver_now
  end
end
