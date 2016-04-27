class ForumPost < ActiveRecord::Base
  validates :content, presence: true, length: { maximum: 6_000 }
  validates :topic, presence: true
  validates :user_id, presence: true

  belongs_to :user
  belongs_to :topic
  has_many :reviews,
           as: :reviewable,
           dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  after_create :touch_topic_and_forum, :notify_topic_watchers

  def to_s
    I18n.t('descriptive_name.forum_post', user: user, topic: topic)
  end

  protected

  def touch_topic_and_forum
    topic.touch
    topic.forum.touch
  end

  def notify_topic_watchers
    topic.notify_watchers(
      self, 'new_forum_post', user
    )
  end
end
