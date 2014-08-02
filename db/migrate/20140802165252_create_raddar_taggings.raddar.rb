# This migration comes from raddar (originally 20140802020431)
class CreateRaddarTaggings < ActiveRecord::Migration
  def change
    create_table :raddar_taggings do |t|
      t.references :tag, index: true
      t.references :taggable, polymorphic: true

      t.timestamps
    end

    add_index :raddar_taggings,
      [:taggable_id, :taggable_type],
      name: 'index_raddar_taggins_taggable'

    add_index :raddar_taggings,
      [:tag_id, :taggable_id, :taggable_type],
      unique: true,
      name: 'index_raddar_taggings_unique_tag'
  end
end
