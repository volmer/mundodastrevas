# This migration comes from raddar (originally 20140802042020)
class CreateRaddarWatches < ActiveRecord::Migration
  def change
    create_table :raddar_watches do |t|
      t.references :user, index: true
      t.references :watchable, polymorphic: true
      t.boolean :active, default: true

      t.timestamps
    end

    add_index :raddar_watches,
      [:watchable_id, :watchable_type],
      name: 'index_raddar_watches_watchable'

    add_index :raddar_watches,
      [:user_id, :watchable_id, :watchable_type],
      unique: true,
      name: 'index_raddar_watches_unique_user'
  end
end
