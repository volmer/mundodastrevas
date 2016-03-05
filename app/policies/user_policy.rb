class UserPolicy < ApplicationPolicy
  def show?
    @user.present?
  end

  def read_field?(field)
    (@record.privacy.try(:[], field.to_s) != 'only_me') || @record == @user
  end
end
