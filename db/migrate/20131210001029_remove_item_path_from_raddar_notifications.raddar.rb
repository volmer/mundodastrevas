# This migration comes from raddar (originally 20131208163935)
class RemoveItemPathFromRaddarNotifications < ActiveRecord::Migration
  def change
    remove_column :raddar_notifications, :item_path, :string
  end
end
