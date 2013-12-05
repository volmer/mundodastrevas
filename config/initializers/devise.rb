Devise.setup do |config|
  # The secret key used by Devise. Devise uses this key to generate
  # random tokens. Changing this key will render invalid all existing
  # confirmation, reset password and unlock tokens in the database.
  config.secret_key = '83a68eaa7fe81bd032dc62cd918767e168f125f4c3899081a072de3058ae7de34739c200311324598e6e399143431f50b0753fa92455465da64c7aee7204702c'

  # ==> OmniAuth
  # Add a new OmniAuth provider. Check the wiki for more information on setting
  # up on your models and hooks.
  config.omniauth :facebook, '330164793746855', 'f543158ab07816a6182632c32c956ab4'
  config.omniauth :twitter, 'yAO2DSZeD85ClNYnGVh2qA', 'EHsbEUZfwzDjniKrNDULsavpoXfziHKBtN6lPBCAX0'

  # Setup a pepper to generate the encrypted password.
  config.pepper = '45d3def659595e449d2c469fb140fc49442c60c0e45d775981a44311d3e757c00a1fa34e20c6f6470ce82571fc89b1ad8b0ca1e6fbc9b60c2ad4056a959a454c'


  # ==> Configuration for :encryptable
  # Allow you to use another encryption algorithm besides bcrypt (default). You can use
  # :sha1, :sha512 or encryptors from others authentication tools as :clearance_sha1,
  # :authlogic_sha512 (then you should set stretches above to 20 for default behavior)
  # and :restful_authentication_sha1 (then you should set stretches to 10, and copy
  # REST_AUTH_SITE_KEY to pepper).
  #
  # Require the `devise-encryptable` gem when using anything other than bcrypt
  config.encryptor = :dark_encryptor
end
