module Notifications
  class BaseDecorator < ::Draper::Decorator
    delegate_all

    include ::Draper::LazyHelpers

    def redirect_path
      fail 'Not yet implemented'
    end

    def text
      fail 'Not yet implemented'
    end

    def mailer_subject
      fail 'Not yet implemented'
    end

    def mailer_template
      event
    end
  end
end
