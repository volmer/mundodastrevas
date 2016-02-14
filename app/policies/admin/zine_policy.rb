module Admin
  class ZinePolicy < ::ZinePolicy
    def index?
      @user.admin?
    end
  end
end
