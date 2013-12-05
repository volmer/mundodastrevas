# This migration comes from raddar_forums (originally 20131128230527)
# This migration comes from raddar_watchers (originally 20131124212633)
class CreateRaddarWatches < ActiveRecord::Migration
  def change
    create_table :raddar_watchers_watches do |t|
      t.references :user, index: true
      t.references :watchable, polymorphic: true
      t.boolean :active, default: true

      t.timestamps
    end

    add_index :raddar_watchers_watches,
      [:watchable_id, :watchable_type],
      name: 'index_raddar_watchers_watches_watchable'

    add_index :raddar_watchers_watches,
      [:user_id, :watchable_id, :watchable_type],
      unique: true,
      name: 'index_raddar_watchers_watches_unique_user'
  end
end
