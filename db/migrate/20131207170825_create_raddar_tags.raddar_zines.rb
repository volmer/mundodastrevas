# This migration comes from raddar_zines (originally 20131203170206)
# This migration comes from raddar_tags (originally 20131202002232)
class CreateRaddarTags < ActiveRecord::Migration
  def change
    create_table :raddar_tags_tags do |t|
      t.string :name

      t.timestamps
    end

    add_index :raddar_tags_tags, :name, unique: true
  end
end
