class FollowershipPolicy < ApplicationPolicy
  def create?
    @user.present?
  end

  def destroy?
    @user.present?
  end

  def followers?
    @user.present?
  end

  def following?
    @user.present?
  end
end
