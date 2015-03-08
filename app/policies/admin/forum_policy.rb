module Admin
  class ForumPolicy < ::ForumPolicy
    def index?
      @user.admin?
    end
  end
end
