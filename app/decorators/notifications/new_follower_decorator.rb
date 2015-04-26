module Notifications
  class NewFollowerDecorator < BaseDecorator
    def redirect_path
      user_path(notifiable.user)
    end

    private

    def text_locals
      { user: notifiable.user }
    end

    def mailer_subject_params
      { user: notifiable.user }
    end
  end
end
