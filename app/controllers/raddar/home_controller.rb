module Raddar
  class HomeController < Raddar::ApplicationController
    skip_after_action :verify_authorized, only: [:index]

    def index
      featured_zines = Zine.with_posts.where(starred: true).order(last_post_at: :desc).limit(4)

      @featured_posts = featured_zines.map {|zine| zine.posts.order(created_at: :desc).first }

      @recent_posts = Zine.with_posts.where.not(id: featured_zines.map(&:id)).order(last_post_at: :desc).limit(4).map {|zine| zine.posts.order('created_at DESC').first }

      @forum_topics = Topic.order(created_at: :desc).limit(4)

      @universes = Universe.order(name: :asc)

      @comments = Comment.order(created_at: :desc).limit(5)

      @featured_zine = Zine.find_by(id: Setting[:featured_zine])
    end
  end
end
