module MailerConcern
  extend ActiveSupport::Concern

  included do
    helper 'application'
    layout 'mailer'
    default from: "#{Rails.application.config.app_name} "\
      "<#{Rails.application.config.default_from}>"
  end
end
