class TopicsController < ApplicationController
  def show
    @forum = Forum.find_by!(slug: params[:forum_id])
    @topic = @forum.topics.find_using_slug(params[:id])

    @topic.update_column(:views, @topic.views + 1)

    @forum_posts = @topic.forum_posts.order(
      created_at: :asc
    ).page(params[:page])

    @forum_post = @topic.forum_posts.new
  end
end
