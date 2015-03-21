class FollowershipPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end

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
