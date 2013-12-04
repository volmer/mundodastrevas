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
end
