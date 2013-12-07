# This migration comes from raddar_zines (originally 20131201182837)
class CreateRaddarPosts < ActiveRecord::Migration
  def change
    create_table :raddar_zines_posts do |t|
      t.references :zine, index: true
      t.text :content
      t.string :image
      t.string :name
      t.integer :views, default: 0
      t.string :slug

      t.timestamps
    end

    add_index :raddar_zines_posts, :slug, unique: true
  end
end
