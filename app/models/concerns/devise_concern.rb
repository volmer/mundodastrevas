require Rails.root + 'lib/devise/encryptable/encryptors/dark_encryptor'

module DeviseConcern
  extend ActiveSupport::Concern

  included do
    attr_accessor :login

    devise :database_authenticatable, :registerable, :omniauthable,
           :recoverable, :rememberable, :trackable, :validatable,
           :confirmable, :encryptable, authentication_keys: [:login]

    def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      login = conditions.delete(:login)

      if login
        where(conditions).where(
          'lower(name) = :value OR lower(email) = :value',
          value: login.downcase
        ).first
      else
        where(conditions).first
      end
    end

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
