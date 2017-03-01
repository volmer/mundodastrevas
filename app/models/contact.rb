class Contact
  include ActiveModel::Model

  EMAIL_FORMAT = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  attr_accessor :email, :message, :name

  validates :message, presence: true, length: { maximum: 6_000 }
  validates :email,
            presence: true,
            format: {
              with: EMAIL_FORMAT,
              allow_blank: true
            }
  validates :name, presence: true
end
