class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :reviewable, polymorphic: true
  has_one :activity, as: :subject, dependent: :destroy

  validates :value, presence: true, inclusion: { in: %w(loved hated) }
  validates :reviewable_id, presence: true
  validates :user_id, presence: true, uniqueness: {
    scope: [:reviewable_id, :reviewable_type]
  }

  after_create :create_activity
  after_update :update_activity

  private

  def activity_privacy
    (value == 'hated') ? 'only_me' : 'public'
  end

  def create_activity
    Activity.create!(
      user: user,
      subject: self,
      key: 'reviews.create',
      privacy: activity_privacy
    )
  end

  def update_activity
    activity.update(privacy: activity_privacy) if changes.include?(:value)
  end
end
