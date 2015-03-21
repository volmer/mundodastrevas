module Admin
  class DashboardPolicy < ApplicationPolicy
    def index?
      @user.try(:admin?).present?
    end
  end
end
