class NotificationPolicy < ApplicationPolicy
  def index?
    @user.present?
  end

  def show?
    @user.present? && @record.user == @user
  end

  def destroy?
    @user.present?
  end
end
