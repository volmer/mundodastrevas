class ZineFollowershipsController < Raddar::FollowershipsController
  private

  def find_followable
    Zine.find_by!(slug: params[:zine_id]) if params[:zine_id].present?
  end
end
