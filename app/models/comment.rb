class Comment < ActiveRecord::Base
  belongs_to :user, class_name: 'Raddar::User'
  belongs_to :post
  has_many :reviews, class_name: 'Raddar::Review', as: :reviewable, dependent: :destroy
  has_many :notifications, class_name: 'Raddar::Notification', as: :notifiable, dependent: :destroy
  has_one :activity, class_name: 'Raddar::Activity', as: :subject, dependent: :destroy

  validates :content, presence: true, length: { maximum: 6_000 }
  validates :user_id, presence: true
  validates :post_id, presence: true

  after_create :create_activity

  def to_s
    I18n.t('comments.to_s', user: user)
  end

  private

  def create_activity
    Raddar::Activity.create!(
      user: user,
      subject: self,
      key: 'comments.create',
      privacy: 'public'
    )
  end
end
