class ForumsController < ApplicationController
  def show
    @forum = Forum.find_by!(slug: params[:id])
    @topics =
      @forum
      .topics.includes(forum_posts: [:user]).order(updated_at: :desc)
  end

  def index
    @forums = Forum.order(:name)
  end
end
