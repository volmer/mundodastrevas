class PostPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def new?
    @record.zine.user == @user
  end

  def create?
    @record.zine.user == @user
  end

  def edit?
    @record.user == @user
  end

  def update?
    @record.user == @user
  end

  def destroy?
    @record.user == @user
  end
end
