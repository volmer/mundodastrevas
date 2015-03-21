class NotificationPolicy < ApplicationPolicy
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

  def show?
    @user.present? && @record.user == @user
  end

  def read?
    @user.present? && @record.user == @user
  end
end
