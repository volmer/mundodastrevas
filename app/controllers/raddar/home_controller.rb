module Raddar
  class HomeController < Raddar::ApplicationController
    skip_after_action :verify_authorized, only: [:index]

    def index
      featured_zines = Zines::Zine.with_posts.where(starred: true).order('updated_at DESC').limit(4)

      @featured_posts = featured_zines.map {|zine| zine.posts.order('created_at DESC').first }

      @recent_posts = Zines::Zine.with_posts.where.not(id: featured_zines.map(&:id)).order('updated_at DESC').limit(5).map {|zine| zine.posts.order('created_at DESC').first }

      @forum_topics = Forums::Topic.order('created_at DESC').limit(6)

      @universes = Universe.all

      @comments = Zines::Comment.order('created_at DESC').limit(6)

      @featured_zine = Raddar::Zines::Zine.find_by(id: Setting[:featured_zine])
    end
  end
end
