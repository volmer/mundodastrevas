class HomeController < ApplicationController
  skip_after_action :verify_authorized, only: [:index]

  def index
    featured_zines ||= Zine.with_posts.includes(:posts).order(
      last_post_at: :desc).limit(6)
    @featured_posts = featured_zines.map { |zine| zine.posts.last }
    @forums = Forum.order(updated_at: :desc).limit(4)
  end
end
