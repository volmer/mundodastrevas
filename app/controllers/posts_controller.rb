class PostsController < ApplicationController
  def index
    @posts = Post.order(created_at: :desc).limit(10)
  end

  def show
    @zine = Zine.find_by!(slug: params[:zine_id])
    @post = @zine.posts.find_by!(slug: params[:id])

    @post.update_column(:views, @post.views + 1)

    @comments = @post.comments.includes(:user).order(created_at: :asc)
    @comment = @post.comments.new
  end
end
