module Notifications
  class BaseDecorator < ::Draper::Decorator
    delegate_all

    include ::Draper::LazyHelpers

    def redirect_path
      fail 'Not yet implemented'
    end

    def text
      render("notifications/#{event}", text_locals)
    end

    def mailer_subject
      t("mailers.notification.#{event}.subject", mailer_subject_params)
    end

    protected

    def text_locals
      {}
    end

    def mailer_subject_params
      {}
    end
  end
end
