module Notifications
  class NewMessageDecorator < BaseDecorator
    def redirect_path
      user_messages_path(notifiable.sender)
    end

    private

    def text_locals
      { user: notifiable.sender }
    end

    def mailer_subject_params
      { user: notifiable.sender }
    end
  end
end
