class Contact
  include ActiveModel::Model

  EMAIL_FORMAT = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  attr_accessor :message, :user
  attr_writer :email, :name

  validates :message, presence: true, length: { maximum: 6_000 }
  validates :email,
            presence: { if: :guest? },
            format: {
              with: EMAIL_FORMAT,
              allow_blank: true
            }
  validates :name, presence: { if: :guest? }

  def email
    guest? ? @email : @user.email
  end

  def name
    guest? ? @name : @user.name
  end

  def guest?
    @user.blank?
  end
end
