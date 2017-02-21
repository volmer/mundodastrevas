class ForumPostsController < ApplicationController
  before_action :set_forum
  before_action :set_topic

  def create
    @forum_post = @topic.forum_posts.new(post_params)
    @forum_post.user = current_user

    authorize(@forum_post)

    if @forum_post.save
      respond_to_create
    else
      respond_to_creation_error
    end
  end

  private

  def set_forum
    @forum = Forum.find_by!(slug: params[:forum_id])
  end

  def set_topic
    @topic = @forum.topics.find_using_slug(params[:topic_id])
  end

  def post_params
    params.require(:forum_post).permit(:content)
  end

  def respond_to_create
    path = forum_topic_path(
      @forum, @topic, page: @topic.forum_posts.page(1).total_pages
    )

    redirect_to path, notice: t('flash.forum_posts.create')
  end

  def respond_to_creation_error
    @forum_posts = @topic.forum_posts.order(created_at: :asc).page(
      params[:page]
    )
    render(template: 'topics/show')
  end
end
