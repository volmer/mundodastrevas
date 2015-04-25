class NotificationPolicy < ApplicationPolicy
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
