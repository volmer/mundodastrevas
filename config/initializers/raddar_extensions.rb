require Rails.root + 'lib/devise/encryptable/encryptors/dark_encryptor'
require Rails.root + 'lib/mundodastrevas/user_extension'

Raddar::User.send(:include, Mundodastrevas::UserExtension)
