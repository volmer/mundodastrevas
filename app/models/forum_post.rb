class ForumPost < ActiveRecord::Base
  validates :content, presence: true, length: { maximum: 6_000 }
  validates :topic, presence: true
  validates :user_id, presence: true

  belongs_to :user
  belongs_to :topic

  after_create :touch_topic_and_forum

  def to_s
    I18n.t('descriptive_name.forum_post', user: user, topic: topic)
  end

  protected

  def touch_topic_and_forum
    topic.touch
    topic.forum.touch
  end
end
