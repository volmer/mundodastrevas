class NotificationMailer < ActionMailer::Base
  include MailerConcern

  def notify(notification)
    @notification = notification
    @user = notification.user
    @notifiable = notification.notifiable

    mail(
      to: "#{@user} <#{@user.email}>",
      subject: subject,
      template_name: @notification.event
    )
  end

  private

  def subject
    t(
      @notification.event,
      scope: 'mailers.notification',
      notifiable: @notifiable
    )
  end
end
