class PostsController < ApplicationController
  def show
    @zine = Zine.find_by!(slug: params[:zine_id])
    @post = @zine.posts.find_by!(slug: params[:id])
    @comments = @post.comments.includes(:user).order(created_at: :asc)
  end
end
