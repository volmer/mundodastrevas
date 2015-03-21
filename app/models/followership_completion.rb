class FollowershipCompletion
  def initialize(followership)
    @followership = followership
  end

  def create
    successful = @followership.save

    notify_followed_user if successful

    successful
  end

  private

  def notify_followed_user
    followable = @followership.followable

    return unless followable.is_a?(User)

    notification            = Notification.new
    notification.user       = followable
    notification.event      = 'new_follower'
    notification.notifiable = @followership
    notification.send!
  end
end