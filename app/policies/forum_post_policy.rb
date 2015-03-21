class ForumPostPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
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
