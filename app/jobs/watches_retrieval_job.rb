class WatchesRetrievalJob < ActiveJob::Base
  queue_as :default

  def perform(watchable, notifiable, event, user_to_skip = nil)
    watchable.active_watches.each do |watch|
      next if watch.user == user_to_skip

      NotificationDeliveryJob.perform_later(
        watch.user, notifiable, event
      )
    end
  end
end
