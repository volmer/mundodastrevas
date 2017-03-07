class PostsController < ApplicationController
  def show
    @zine = Zine.find_by!(slug: params[:zine_id])
    @post = @zine.posts.find_by!(slug: params[:id])
  end
end
