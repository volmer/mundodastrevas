class ForumPostCompletion
  def initialize(forum_post)
    @forum_post = forum_post
  end

  # Public: saves the forum post, and if the operation if successful,
  # sends notifications for all topic watchers. Also sets the forum
  # post user as a watcher.
  #
  # - watch_params: The Array with attributes to populate the
  # user `watch` relation with the forum post topic.
  def create(watch_params)
    successful = @forum_post.save

    if successful
      @forum_post.topic.notify_watchers(
        @forum_post, 'new_forum_post', @forum_post.user
      )

      @forum_post.topic.set_watcher!(@forum_post.user, watch_params)
    end

    successful
  end
end
