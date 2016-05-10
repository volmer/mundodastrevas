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
      forum_post_path
    when 'new_message'
      user_messages_path(notifiable.sender)
    when 'new_rank'
      universe_path(notifiable.universe, anchor: 'tab-ranks')
    end
  end

  def forum_post_path
    path_options = {}
    last_page = notifiable.topic.forum_posts.page.num_pages

    path_options[:page] = last_page if last_page > 1

    forum_topic_path(notifiable.topic.forum, notifiable.topic, path_options)
  end

  def notifiable
    @notification.notifiable
  end
end
