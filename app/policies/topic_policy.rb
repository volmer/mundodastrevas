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
end
