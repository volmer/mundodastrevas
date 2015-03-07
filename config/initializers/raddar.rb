# Use this setup block to configure all options available to Raddar.
Raddar.setup do |config|
  # The name of your app. It is used in views and mailers.
  config.app_name = 'Mundo das Trevas'

  # The email address used by mailers as the `from` header.
  config.default_from = 'admin@mundodastrevas.com'

  # The email address where all contact messages will be sent to.
  config.contacts_destination = 'contato@mundodastrevas.com'

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

Raddar::Notifications.decorators_mapping.merge!(
  new_rank: 'NewRankDecorator',
  new_comment: 'NewCommentDecorator',
  new_forum_post: 'NewForumPostDecorator'
)

Raddar.main_links << { text: ->{ I18n.t('links.zines.main') }, href: ->{ Rails.application.routes.url_helpers.zines_path } }
Raddar.main_links << { text: ->{ I18n.t('links.forums.main') }, href: ->{ Rails.application.routes.url_helpers.forums_path } }

Raddar.admin_links << { text: ->{ I18n.t('links.zines.admin') }, href: ->{ Raddar::Engine.routes.url_helpers.admin_zines_path }, active: :zines }
Raddar.admin_links << { text: ->{ I18n.t('links.forums.admin') }, href: ->{ Raddar::Engine.routes.url_helpers.admin_forums_path }, active: :forums }

Raddar.user_menu << ->(context) { context.link_to(('<span class="glyphicon glyphicon-book"></span> ' + I18n.t('links.zines.user_menu')).html_safe, context.main_app.user_zines_path(context.current_user)) }
