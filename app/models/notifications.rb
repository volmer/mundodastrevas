# Public: Maps event types with decorators to provide markup and texts
# for event notifications.
module Notifications
  DECORATORS = {
    new_comment: NewCommentDecorator,
    new_follower: NewFollowerDecorator,
    new_forum_post: NewForumPostDecorator,
    new_message: NewMessageDecorator,
    new_rank: NewRankDecorator
  }.freeze

  def self.decorator_for(notification)
    DECORATORS[notification.event.to_sym].new(notification)
  end

  def self.events
    DECORATORS.keys.map(&:to_s)
  end
end
