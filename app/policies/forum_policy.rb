class ForumPolicy < ApplicationPolicy
  def show?
    true
  end

  def index?
    true
  end
end
