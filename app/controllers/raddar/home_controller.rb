module Raddar
  class HomeController < Raddar::ApplicationController
    skip_after_action :verify_authorized, only: [:index]

    def index
      featured_zines = Zine.with_posts.includes(:posts).where(starred: true).order(last_post_at: :desc).limit(4)

      @featured_posts = featured_zines.map {|zine| zine.posts.last }

      @recent_posts = Zine.with_posts.includes(:posts).where.not(id: featured_zines.map(&:id)).order(last_post_at: :desc).limit(4).map {|zine| zine.posts.last }

      @forum_topics = Topic.includes(:forum).order(created_at: :desc).limit(4)

      @universes = Universe.order(name: :asc)

      @comments = Comment.includes(:user, post: [:zine]).order(created_at: :desc).limit(5)

      @featured_zine = Zine.find_by(id: Setting[:featured_zine])

      @new_members = Raddar::User.where.not(confirmed_at: nil).order(created_at: :desc).limit(6)
    end
  end
end
