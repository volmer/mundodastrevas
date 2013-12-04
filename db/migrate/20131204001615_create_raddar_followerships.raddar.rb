# This migration comes from raddar (originally 20131013222926)
class CreateRaddarFollowerships < ActiveRecord::Migration
  def change
    create_table :raddar_followerships do |t|
      t.references :user, index: true
      t.references :followable, polymorphic: true, index: true

      t.timestamps
    end

    add_index :raddar_followerships, [:user_id, :followable_id, :followable_type],
      unique: true,
      name: 'index_raddar_followerships_on_user_and_followable'
  end
end
