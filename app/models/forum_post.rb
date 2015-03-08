class ForumPost < ActiveRecord::Base
  include PgSearch

  multisearchable against: [:content]

  validates :content, presence: true, length: { maximum: 6_000 }
  validates :topic, presence: true
  validates :user_id, presence: true

  belongs_to :user, class_name: 'Raddar::User'
  belongs_to :topic
  has_many :reviews,
           class_name: 'Raddar::Review',
           as: :reviewable,
           dependent: :destroy
  has_many :notifications, class_name: 'Raddar::Notification', as: :notifiable, dependent: :destroy
  has_one :activity, class_name: 'Raddar::Activity', as: :subject, dependent: :destroy

  after_create :touch_topic_and_forum, :create_activity

  def to_s
    I18n.t('forum_posts.to_s', user: user)
  end

  protected

  def touch_topic_and_forum
    topic.touch
    topic.forum.touch
  end

  def create_activity
    Raddar::Activity.create!(
      user: user,
      subject: self,
      key: 'forum_posts.create',
      privacy: 'public'
    )
  end
end
