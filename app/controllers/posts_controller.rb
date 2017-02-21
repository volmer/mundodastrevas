class PostsController < ApplicationController
  before_action :set_zine, only: [:show]
  before_action :set_post, only: [:show]

  def index
    authorize(Post.new)

    @posts = Post.order(created_at: :desc).limit(10)
  end

  def show
    @post.update_column(:views, @post.views + 1)
    @comments = @post.comments.includes(:user).order(created_at: :asc)

    @comment = @post.comments.new
  end

  private

  def set_zine
    @zine = Zine.find_by!(slug: params[:zine_id])
  end

  def set_post
    @post = @zine.posts.find_by!(slug: params[:id])

    authorize(@post)
  end
end
