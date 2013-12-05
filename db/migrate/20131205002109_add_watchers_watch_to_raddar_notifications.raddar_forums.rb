# This migration comes from raddar_forums (originally 20131128230528)
# This migration comes from raddar_watchers (originally 20131128203740)
class AddWatchersWatchToRaddarNotifications < ActiveRecord::Migration
  def change
    add_reference :raddar_notifications, :watchers_watch, index: true
  end
end
