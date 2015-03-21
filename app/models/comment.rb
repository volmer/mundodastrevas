class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  has_many :reviews, as: :reviewable, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy
  has_one :activity, as: :subject, dependent: :destroy

  validates :content, presence: true, length: { maximum: 6_000 }
  validates :user_id, presence: true
  validates :post_id, presence: true

  after_create :create_activity

  def to_s
    I18n.t('comments.to_s', user: user)
  end

  private

  def create_activity
    Activity.create!(
      user: user,
      subject: self,
      key: 'comments.create',
      privacy: 'public'
    )
  end
end
