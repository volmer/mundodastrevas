module Notifications
  class NewCommentDecorator < BaseDecorator
    def redirect_path
      zine_post_path(zine, post)
    end

    private

    def text_locals
      { post: post, user: notifiable.user }
    end

    def mailer_subject_params
      { post: post }
    end

    def post
      notifiable.post
    end

    def zine
      post.zine
    end
  end
end
