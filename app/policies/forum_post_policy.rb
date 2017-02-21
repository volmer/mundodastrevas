class ForumPostPolicy < ApplicationPolicy
  def create?
    @user.present?
  end
end
