class TopicPolicy < ApplicationPolicy
  def show?
    true
  end

  def new?
    @user.present?
  end

  def create?
    @user.present?
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
