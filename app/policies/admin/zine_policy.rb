module Admin
  class ZinePolicy < ::ZinePolicy
    def index?
      @user.admin?
    end

    def edit?
      @user.admin?
    end

    def update?
      @user.admin?
    end
  end
end
