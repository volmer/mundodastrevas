class ZinesController < ApplicationController
  def index
    @zines = Zine.all.order(:name)
  end

  def show
    @zine = Zine.find_by!(slug: params[:id])
    @posts = @zine.posts.order(created_at: :desc)
  end
end
