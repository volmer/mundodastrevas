class Followership < ActiveRecord::Base
  belongs_to :user
  belongs_to :followable, polymorphic: true, inverse_of: :followers
  has_many :notifications, as: :notifiable, dependent: :destroy
  has_many :activities, as: :subject, dependent: :destroy

  validates :user_id, presence: true, uniqueness: {
    scope: [:followable_id, :followable_type]
  }
  validates :followable_id, presence: true
  validate :user_and_followable_must_be_different

  after_create :create_follow_activity, :notify_followed_user

  private

  def user_and_followable_must_be_different
    return if user.blank? || user != followable

    errors[:base] << 'Users cannot follow themselves.'
  end

  def create_follow_activity
    Activity.create!(
      user: user,
      subject: self,
      key: 'followerships.create',
      privacy: 'public'
    )
  end

  def notify_followed_user
    return unless followable.is_a?(User)
    notification            = Notification.new
    notification.user       = followable
    notification.event      = 'new_follower'
    notification.notifiable = self
    notification.send!
  end
end
