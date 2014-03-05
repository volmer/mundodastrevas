# Use this setup block to configure all options available to Raddar.
Raddar.setup do |config|
  # The name of your app. It is used in views and mailers.
  config.app_name = 'Mundo das Trevas'

  # The email address used by mailers as the `from` header.
  config.default_from = 'admin@mundodastrevas.com'

  # The email address where all contact messages will be sent to.
  config.contacts_destination = 'admin@mundodastrevas.com'

  # Links to be added to the navbar. Populate this array with hashes
  # that respond to :text and :href (is values must be callable).
  # You can also override the partial layouts/raddar/main_links to
  # change the markup.
  # config.main_links = []

  # Links to be added to the admin tabs. Populate this array with
  # hashes that responds to :text and :href (is values must be
  # callable). An optional :active can also be passed to set the
  # link as active. You can also override the partial
  # raddar/admin/shared/tabs to change the markup.
  # config.admin_links = []

  # Items to be appended to the user menu. Populate this array with
  # callable objects which accepts a context argument.
  # You can also override the partial
  # layouts/raddar/user_menu to change the markup.
  # config.user_menu = []
end

Raddar::Notifications.decorators_mapping[:new_rank] = 'NewRankDecorator'

