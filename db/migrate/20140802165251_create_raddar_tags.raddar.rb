# This migration comes from raddar (originally 20140802020311)
class CreateRaddarTags < ActiveRecord::Migration
  def change
    create_table :raddar_tags do |t|
      t.string :name

      t.timestamps
    end

    add_index :raddar_tags, :name, unique: true
  end
end
