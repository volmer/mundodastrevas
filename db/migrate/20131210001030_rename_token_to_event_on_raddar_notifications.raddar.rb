# This migration comes from raddar (originally 20131209000126)
class RenameTokenToEventOnRaddarNotifications < ActiveRecord::Migration
  def change
    change_table :raddar_notifications do |t|
      t.rename :token, :event
    end
  end
end
