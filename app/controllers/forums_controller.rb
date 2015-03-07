class ForumsController < ApplicationController
  def show
    @forum = Forum.find_by!(slug: params[:id])
    @topics = @forum.topics.order('updated_at DESC').page(params[:page])

    authorize(@forum)
  end

  def index
    authorize(Forum.new)

    @forums = Forum.order('updated_at DESC')

    @recent_topics = Topic.order('created_at DESC').limit(5)
    @recent_posts = ForumPost.order('created_at DESC').limit(5)
  end
end
