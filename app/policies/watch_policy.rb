class WatchPolicy < ApplicationPolicy
  def create?
    @user.present?
  end

  def update?
    @user.present? && @record.user == @user
  end
end
