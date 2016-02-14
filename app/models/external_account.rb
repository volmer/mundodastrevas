class ExternalAccount < ActiveRecord::Base
  belongs_to :user

  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :url, presence: true, uniqueness: { scope: :provider }
  validates :token, presence: true, uniqueness: { scope: :provider }
  validates :user_id, uniqueness: { scope: :provider }
  validates :user, presence: true

  def to_s
    name.presence || email
  end
end
