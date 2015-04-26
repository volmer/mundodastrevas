module Notifications
  class NewRankDecorator < BaseDecorator
    def redirect_path
      universe_path(universe, anchor: 'tab-ranks')
    end

    private

    def text_locals
      { rank: notifiable, universe: universe }
    end

    def mailer_subject_params
      { rank: notifiable }
    end

    def universe
      notifiable.universe
    end
  end
end
