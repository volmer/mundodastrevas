# This migration comes from raddar (originally 20131021134623)
class CreateRaddarNotifications < ActiveRecord::Migration
  def change
    create_table :raddar_notifications do |t|
      t.string :token
      t.string :item_path
      t.boolean :unread, default: true
      t.references :user, index: true
      t.references :notifiable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
