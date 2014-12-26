class CommentCompletion
  def initialize(comment)
    @comment = comment
  end

  # Public: saves the comment, and if the operation if successful,
  # sends notifications for all post watchers. Also sets the
  # comment user as a watcher.
  #
  # - watch_params: The Array with attributes to populate the
  # user `watch` relation with the post.
  def create(watch_params)
    successful = @comment.save

    if successful
      @comment.post.notify_watchers(
        @comment, 'new_comment', @comment.user
      )

      @comment.post.set_watcher!(@comment.user, watch_params)
    end

    successful
  end
end
