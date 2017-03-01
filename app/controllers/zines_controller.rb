class ZinesController < ApplicationController
  def index
    @zines = Zine.with_posts.order(
      last_post_at: :desc
    ).page(params[:page])

    @most_read_posts = Post.order(views: :desc).limit(5)
  end

  def show
    @zine = Zine.find_by!(slug: params[:id])
    @posts = @zine.posts.order(created_at: :desc).page(params[:page])
  end
end
