class NotificationMailer < ActionMailer::Base
  helper 'application'
  layout 'mailer'
  default from: "#{ Rails.application.config.app_name } "\
    "<#{ Rails.application.config.default_from }>"

  def notify(notification)
    @notification = notification
    @user         = notification.user
    @notifiable   = notification.notifiable

    decorator = Notifications.decorator_for(notification)

    mail(
      to: "#{ @user } <#{ @user.email }>",
      subject: decorator.mailer_subject,
      template_name: decorator.mailer_template
    )
  end
end
