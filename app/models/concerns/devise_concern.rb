module DeviseConcern
  extend ActiveSupport::Concern

  included do
    devise :database_authenticatable, :registerable, :omniauthable,
           :recoverable, :rememberable, :trackable, :validatable,
           :confirmable

    def active_for_authentication?
      super && active?
    end

    def inactive_message
      active? ? super : I18n.t('flash.users.sessions.blocked')
    end

    def self.new_with_session(params, session)
      super.tap do |user|
        if session['devise.omniauth_data']
          # Need to mind the key format due to the session serialization.
          data = session['devise.omniauth_data'].with_indifferent_access
          OmniauthCompletion.populate(user, data)

          account = OmniauthCompletion.build_account(data, user)

          user.external_accounts << account
        end
      end
    end
  end
end
