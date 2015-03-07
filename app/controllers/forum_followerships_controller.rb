class ForumFollowershipsController < Raddar::FollowershipsController
  private

  def find_followable
    Forum.find_by!(slug: params[:forum_id]) if params[:forum_id].present?
  end
end
