class ForumPolicy < ApplicationPolicy
  def show?
    true
  end

  def new?
    @user.admin?
  end

  def create?
    @user.admin?
  end

  def index?
    true
  end

  def edit?
    @user.admin?
  end

  def update?
    @user.admin?
  end

  def destroy?
    @user.admin?
  end
end
