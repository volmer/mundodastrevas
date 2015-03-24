module Admin
  class HomeController < ApplicationController
    def index
      authorize(self)

      @registered_users_count = User.count
      @confirmed_users_count = User.where('confirmed_at IS NOT NULL').count
      @blocked_users_count = User.where(state: 'blocked').count
      @messages_count = Message.count
    end

    def self.policy_class
      Admin::DashboardPolicy
    end
  end
end
