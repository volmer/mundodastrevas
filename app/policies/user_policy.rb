class UserPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end

  def show?
    @user.present?
  end

  def read_field?(field)
    (@record.privacy.try(:[], field.to_s) != 'only_me') || (@user == @record)
  end
end
