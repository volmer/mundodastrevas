class ZinesController < ApplicationController
  before_action :set_zine, only: [:show]

  def index
    authorize(Zine.new)

    @zines = Zine.with_posts.order(
      last_post_at: :desc
    ).page(params[:page])

    @most_read_posts = Post.order(views: :desc).limit(5)
  end

  def show
    @posts = @zine.posts.order(created_at: :desc).page(params[:page])
  end

  private

  def set_zine
    @zine = Zine.find_by!(slug: params[:id])

    authorize(@zine)
  end
end
