module Watchable
  extend ActiveSupport::Concern

  included do
    has_many :watches,
             as: :watchable,
             dependent: :destroy

    def set_watcher!(user, watch_params)
      build_watch(user, watch_params).save!
    end

    def set_watcher(user, watch_params)
      build_watch(user, watch_params).save
    end

    def watched_by?(user)
      watches.find_by(user: user, active: true).present?
    end

    def notify_watchers(notifiable, event, skip_user)
      WatchesRetrievalJob.perform_later(
        self, notifiable, event, skip_user
      )
    end

    def active_watches
      watches.where(active: true)
    end

    private

    def build_watch(user, watch_params)
      watch = watches.find_or_initialize_by(user: user)
      watch.active = watch_params[:active]
      watch
    end
  end
end
