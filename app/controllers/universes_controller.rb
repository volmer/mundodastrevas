class UniversesController < ApplicationController
  def show
    @universe = Universe.find_by!(slug: params[:id])

    authorize(@universe)

    @zines = @universe.zines.with_posts.where("zines.image <> ''").order(
      last_post_at: :desc
    ).page(params[:page])
    @forum = @universe.forums.first

    return if @forum.blank?
    @forum_topics = @forum.topics.order(updated_at: :desc).limit(10)
  end
end
