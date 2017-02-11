class NotificationsController < ApplicationController
  def index
    authorize(Notification.new)

    @notifications =
      current_user
      .notifications
      .order(unread: :desc, created_at: :desc)
      .page(params[:page])
  end

  def show
    @notification = Notification.find(params[:id])
    authorize(@notification)
    @notification.update_attribute(:unread, false)

    redirect_to redirect_path
  end

  def destroy
    authorize(Notification.new)

    current_user.notifications.delete_all

    redirect_to notifications_path
  end

  private

  def redirect_path
    case @notification.event
    when 'new_comment'
      zine_post_path(notifiable.post.zine, notifiable.post)
    when 'new_forum_post'
      forum_topic_path(notifiable.topic.forum, notifiable.topic)
    when 'new_message'
      user_messages_path(notifiable.sender)
    when 'new_rank'
      universe_path(notifiable.universe, anchor: 'tab-ranks')
    end
  end

  def notifiable
    @notification.notifiable
  end
end
