class ForumsController < ApplicationController
  def show
    @forum = Forum.find_by!(slug: params[:id])
    @topics = @forum.topics.recent.page(params[:page])

    authorize(@forum)
  end

  def index
    authorize(Forum.new)

    @forums = Forum.order(updated_at: :desc)

    @topics = Topic.order(created_at: :desc).limit(5)
    @posts = ForumPost.order(created_at: :desc).limit(5)
  end
end
