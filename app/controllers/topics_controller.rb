class TopicsController < ApplicationController
  before_action :set_forum
  before_action :set_topic

  def show
    @topic.update_column(:views, @topic.views + 1)

    @forum_posts = @topic.forum_posts.order(
      created_at: :asc
    ).page(params[:page])

    @forum_post = @topic.forum_posts.new
  end

  private

  def set_forum
    @forum = Forum.find_by!(slug: params[:forum_id])
  end

  def set_topic
    @topic = @forum.topics.find_using_slug(params[:id])

    authorize(@topic)
  end
end
