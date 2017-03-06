class TopicsController < ApplicationController
  def show
    @forum = Forum.find_by!(slug: params[:forum_id])
    @topic = @forum.topics.find_using_slug(params[:id])
    @forum_posts = @topic.forum_posts.order(created_at: :asc)
  end
end
