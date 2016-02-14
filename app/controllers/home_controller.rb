class HomeController < ApplicationController
  skip_after_action :verify_authorized, only: [:index]

  def index
    @featured_posts = featured_posts
    @recent_posts = recent_posts
    @forum_topics = forum_topics
    @universes = Universe.order(name: :asc)
    @comments = comments
    @new_members = new_members
    @new_levels = new_levels
  end

  private

  def featured_zines
    @featured_zines ||= Zine.with_posts.includes(:posts).order(
      last_post_at: :desc).limit(4)
  end

  def featured_posts
    featured_zines.map { |zine| zine.posts.last }
  end

  def recent_posts
    Zine.with_posts.includes(:posts).where.not(
      id: featured_zines.map(&:id)
    ).order(last_post_at: :desc).limit(4).map { |zine| zine.posts.last }
  end

  def forum_topics
    Topic.includes(:forum).order(created_at: :desc).limit(4)
  end

  def comments
    Comment.includes(:user, post: [:zine]).order(
      created_at: :desc
    ).limit(5)
  end

  def new_members
    User.where.not(confirmed_at: nil).order(
      created_at: :desc
    ).limit(6)
  end

  def new_levels
    Level.where.not(updated_at: nil).where('value > 1').order(
      updated_at: :desc).limit(5)
  end
end
