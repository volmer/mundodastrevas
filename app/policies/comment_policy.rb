class CommentPolicy < Raddar::ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end

  def create?
    @user.present?
  end

  def destroy?
    @record.user == @user
  end
end
