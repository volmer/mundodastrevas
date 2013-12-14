module Raddar
  class HomeController < Raddar::ApplicationController
    skip_after_action :verify_authorized, only: [:index]

    def index
      @featured_posts = Zines::Zine.with_posts.where(starred: true).order('updated_at DESC').limit(4).map {|zine| zine.posts.order('created_at DESC').first }

      @recent_posts = Zines::Zine.with_posts.where(starred: false).order('updated_at DESC').limit(5).map {|zine| zine.posts.order('created_at DESC').first }

      @forum_topics = Forums::Topic.order('created_at DESC').limit(6)

      @universes = Universe.all

      @comments = Zines::Comment.order('created_at DESC').limit(6)
    end
  end
end
