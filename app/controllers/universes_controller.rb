class UniversesController < ApplicationController
  def show
    @universe = Universe.find_by!(slug: params[:id])

    authorize(@universe)

    @ranks = @universe.ranks.order('value DESC')
    @zines = @universe.zines.with_posts.where("raddar_zines_zines.image <> ''").order('last_post_at DESC').page(params[:page])
    @forum = @universe.forums.first
    @forum_topics = @forum.topics.order('updated_at DESC').limit(10) if @forum.present?
  end
end
