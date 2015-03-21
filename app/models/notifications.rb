# Public: Maps event types with decorators to provide markup and texts
# for event notifications.
# rubocop:disable Style/ClassVars
module Notifications
  mattr_accessor :decorators_mapping
  @@decorators_mapping = {
    new_follower: 'Notifications::NewFollowerDecorator',
    new_message: 'Notifications::NewMessageDecorator',
    new_rank: 'NewRankDecorator',
    new_comment: 'NewCommentDecorator',
    new_forum_post: 'NewForumPostDecorator'
  }

  def self.decorator_for(notification)
    @@decorators_mapping[notification.event.to_sym].constantize.new(
      notification
    )
  end
end
