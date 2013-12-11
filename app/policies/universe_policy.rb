class UniversePolicy < Raddar::ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end

  def show?
    true
  end

  def new?
    @user.admin?
  end

  def create?
    @user.admin?
  end

  def index?
    @user.admin?
  end

  def edit?
    @user.admin?
  end

  def update?
    @user.admin?
  end

  def destroy?
    @user.admin?
  end
end
