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

  after_create :create_follow_activity

  private

  def user_and_followable_must_be_different
    return if user.blank? || user != followable

    errors[:base] << 'User cannot follow himself/herself.'
  end

  def create_follow_activity
    Activity.create!(
      user: user,
      subject: self,
      key: 'followerships.create',
      privacy: 'public'
    )
  end
end
