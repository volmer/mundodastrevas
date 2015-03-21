class NewCommentDecorator < Notifications::BaseDecorator
  def mailer_subject
    t 'mailers.new_comment.subject', post: post
  end

  def text
    render 'comments/notification', post: post, user: user
  end

  def redirect_path
    zine_post_path(zine, post)
  end

  private

  def post
    object.notifiable.post
  end

  def user
    object.notifiable.user
  end

  def zine
    post.zine
  end
end
