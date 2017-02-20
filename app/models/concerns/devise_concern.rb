module DeviseConcern
  extend ActiveSupport::Concern

  included do
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable,
           :confirmable

    def active_for_authentication?
      super && active?
    end

    def inactive_message
      active? ? super : I18n.t('flash.users.sessions.blocked')
    end
  end
end
