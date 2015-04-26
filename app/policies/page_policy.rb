class PagePolicy < ApplicationPolicy
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
    @user.admin?
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
