class MessagePolicy < ApplicationPolicy
  def index?
    @user.present?
  end

  def create?
    @user.present? && @record.sender == @user
  end
end
