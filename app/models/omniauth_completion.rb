class OmniauthCompletion
  class << self
    def complete(auth_data, user = nil)
      user ||= find_or_create_user(auth_data)
      associate_account_with_user(user, auth_data)
      populate(user, auth_data)
      confirm_and_save(user)

      user
    end

    def populate(user, auth_data)
      apply_facebook_specific_params(auth_data, user)
      apply_general_params(auth_data, user)
    end

    # rubocop:disable Metrics/MethodLength
    def build_account(auth_data, user)
      ExternalAccount.new(
        user:     user,
        provider: auth_data[:provider],
        token:    auth_data[:credentials][:token],
        secret:   auth_data[:credentials][:secret],
        verified: auth_data[:info][:verified],
        name:     auth_data[:info][:nickname],
        uid:      auth_data[:uid],
        email:    auth_data[:info][:email],
        url:      auth_data[:info][:urls][
          auth_data[:provider].titleize.to_sym
        ]
      )
    end

    private

    def find_or_create_user(auth_data)
      account = ExternalAccount.find_by(
        provider: auth_data[:provider], uid: auth_data[:uid]
      )

      if account.present?
        account.user
      else
        User.find_by(email: auth_data[:info][:email]) ||
          User.new(password: Devise.friendly_token[0, 20])
      end
    end

    def confirm_and_save(user)
      return unless user.valid?
      user.confirm if user.new_record?
      user.save
    end

    def associate_account_with_user(user, auth_data)
      return if user.blank?

      account = ExternalAccount.find_by(
        provider: auth_data[:provider], uid: auth_data[:uid]
      )

      if account.present?
        raise 'Another user already owns this account.' if account.user != user
      else
        user.external_accounts << build_account(auth_data, user)
      end
    end

    def apply_facebook_specific_params(auth_data, user)
      return if auth_data[:provider] != 'facebook'

      if user.avatar.blank?
        user.remote_avatar_url = parse_facebook_image(auth_data)
      end

      user.birthday ||= parse_facebook_birthday(auth_data)
      user.gender ||= auth_data[:extra][:raw_info][:gender]
    end

    def apply_general_params(auth_data, user)
      user.email = auth_data[:info][:email] if user.email.blank?
      user.name ||= auth_data[:info][:nickname]
      user.bio ||= auth_data[:info][:description]
      user.location ||= auth_data[:info][:location]
      user.remote_avatar_url ||= auth_data[:info][:image] if user.avatar.blank?
    end

    def parse_facebook_image(auth_data)
      uri = URI(auth_data[:info][:image])
      query = URI.decode_www_form(uri.query || '') << %w(type large)
      uri.query = URI.encode_www_form(query)

      uri.to_s
    end

    def parse_facebook_birthday(auth_data)
      birthday = auth_data[:extra][:raw_info][:birthday]
      Date.strptime(birthday, '%m/%d/%Y') if birthday
    end
  end
end
