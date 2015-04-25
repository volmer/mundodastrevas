class Message < ActiveRecord::Base
  belongs_to :sender, class_name: 'User', inverse_of: :sent_messages
  belongs_to :recipient, class_name: 'User', inverse_of: :incoming_messages
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :sender_id, presence: true
  validates :recipient_id, presence: true
  validates :content, length: { maximum: 2_000 }
  validate :sender_and_recipient_must_be_different

  after_create :notify_recipient

  scope(:distinct_for, lambda do |user|
    joins(
      "INNER JOIN (
        SELECT user_id, MAX(id) AS id FROM (
          SELECT id, sender_id AS user_id
          FROM messages WHERE recipient_id = #{user.id}
          UNION
          SELECT id, recipient_id AS user_id
          FROM messages WHERE sender_id = #{user.id}
        ) i
        GROUP BY user_id
      ) AS ids ON ids.id = messages.id"
    ).order('created_at DESC')
  end)

  scope(:all_between, lambda do |user1, user2|
    where(
      '(sender_id = :user1 AND recipient_id = :user2)
        OR
        (sender_id = :user2 AND recipient_id = :user1)',
      user1: user1,
      user2: user2
    ).order('created_at DESC')
  end)

  private

  def sender_and_recipient_must_be_different
    return if sender.blank? || sender != recipient

    errors[:base] << 'User cannot send a message to himself/herself.'
  end

  def notify_recipient
    notification            = Notification.new
    notification.user       = recipient
    notification.event      = 'new_message'
    notification.notifiable = self
    notification.send!
  end
end
