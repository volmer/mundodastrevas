module Notifications
  class NewForumPostDecorator < BaseDecorator
    def redirect_path
      path_options = {}
      last_page = topic.forum_posts.page.num_pages

      path_options[:page] = last_page if last_page > 1

      forum_topic_path(forum, topic, path_options)
    end

    private

    def text_locals
      { topic: topic, user: notifiable.user }
    end

    def mailer_subject_params
      { topic: topic }
    end

    def topic
      notifiable.topic
    end

    def forum
      notifiable.topic.forum
    end
  end
end
