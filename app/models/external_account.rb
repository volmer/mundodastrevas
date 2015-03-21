class ExternalAccount < ActiveRecord::Base
  belongs_to :user
  has_one :activity, as: :subject, dependent: :destroy

  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :name, presence: true, uniqueness: { scope: :provider }
  validates :url, presence: true, uniqueness: { scope: :provider }
  validates :token, presence: true, uniqueness: { scope: :provider }
  validates :user_id, uniqueness: { scope: :provider }
  validates :user, presence: true

  after_create :create_activity

  private

  def create_activity
    privacy = user.privacy.try(:[], provider) || 'public'
    Activity.create!(
      user: user,
      subject: self,
      key: 'external_accounts.create',
      privacy: privacy
    )
  end
end
