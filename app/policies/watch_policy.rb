class WatchPolicy < ApplicationPolicy
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

  def update?
    @user.present? && @record.user == @user
  end
end
