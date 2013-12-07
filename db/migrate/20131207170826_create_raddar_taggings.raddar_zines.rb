# This migration comes from raddar_zines (originally 20131203170207)
# This migration comes from raddar_tags (originally 20131202003034)
class CreateRaddarTaggings < ActiveRecord::Migration
  def change
    create_table :raddar_tags_taggings do |t|
      t.references :tag, index: true
      t.references :taggable, polymorphic: true

      t.timestamps
    end

    add_index :raddar_tags_taggings,
      [:taggable_id, :taggable_type],
      name: 'index_raddar_tags_taggins_taggable'

    add_index :raddar_tags_taggings,
      [:tag_id, :taggable_id, :taggable_type],
      unique: true,
      name: 'index_raddar_tags_taggings_unique_tag'
  end
end
