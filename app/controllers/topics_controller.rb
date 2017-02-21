class TopicsController < ApplicationController
  before_action :set_forum
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  def show
    @topic.update_column(:views, @topic.views + 1)

    @forum_posts = @topic.forum_posts.order(
      created_at: :asc
    ).page(params[:page])

    @forum_post = @topic.forum_posts.new
  end

  def new
    @topic = @forum.topics.new

    authorize(@topic)

    @topic.forum_posts << ForumPost.new
  end

  def create
    @topic = @forum.topics.new(topic_params)
    @topic.user = current_user
    @topic.forum_posts.first.topic = @topic
    @topic.forum_posts.first.user = current_user

    authorize(@topic)

    if @topic.save
      redirect_to [@forum, @topic], notice: t('flash.topics.create')
    else
      render action: 'new'
    end
  end

  private

  def set_forum
    @forum = Forum.find_by!(slug: params[:forum_id])
  end

  def set_topic
    @topic = @forum.topics.find_using_slug(params[:id])

    authorize(@topic)
  end

  def topic_params
    params.require(:topic).permit(:name, forum_posts_attributes: [:content])
  end
end
