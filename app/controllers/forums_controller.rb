class ForumsController < ApplicationController
  def show
    @forum = Forum.find_by!(slug: params[:id])
    @topics = @forum.topics.recent
  end

  def index
    @forums = Forum.order(:name)
  end
end
