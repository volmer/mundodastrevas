module Notifications
  class NewMessageDecorator < BaseDecorator
    def redirect_path
      user_messages_path(notifiable.sender)
    end

    def text
      render 'notifications/new_message', user: notifiable.sender
    end

    def mailer_subject
      I18n.t 'mailers.notification.new_message.subject',
             user: notifiable.sender
    end
  end
end
