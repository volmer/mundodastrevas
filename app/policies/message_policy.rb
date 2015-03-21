class MessagePolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end

  def index?
    @user.present?
  end

  def create?
    @user.present? && @record.sender == @user
  end
end
