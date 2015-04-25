class NewForumPostDecorator < Notifications::BaseDecorator
  def mailer_subject
    t 'mailers.new_forum_post.subject', topic: topic
  end

  def text
    render 'forum_posts/notification', topic: topic, user: user
  end

  def redirect_path
    path_options = {}
    last_page = topic.forum_posts.page.num_pages

    path_options[:page] = last_page if last_page > 1

    forum_topic_path(forum, topic, path_options)
  end

  private

  def topic
    object.notifiable.topic
  end

  def user
    object.notifiable.user
  end

  def forum
    object.notifiable.topic.forum
  end
end
