class NotificationMailer < ActionMailer::Base
  include MailerConcern

  def notify(notification)
    @notification = notification
    @user         = notification.user
    @notifiable   = notification.notifiable

    decorator = Notifications.decorator_for(notification)

    mail(
      to: "#{ @user } <#{ @user.email }>",
      subject: decorator.mailer_subject,
      template_name: @notification.event
    )
  end
end
