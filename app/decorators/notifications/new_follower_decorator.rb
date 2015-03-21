module Notifications
  class NewFollowerDecorator < BaseDecorator
    def redirect_path
      user_path(notifiable.user)
    end

    def text
      render 'notifications/new_follower', user: notifiable.user
    end

    def mailer_subject
      I18n.t 'mailers.notification.new_follower.subject',
             user: notifiable.user
    end
  end
end
