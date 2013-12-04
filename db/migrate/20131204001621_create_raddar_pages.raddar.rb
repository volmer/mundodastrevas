# This migration comes from raddar (originally 20131111191736)
class CreateRaddarPages < ActiveRecord::Migration
  def change
    create_table :raddar_pages do |t|
      t.text :content
      t.string :title
      t.string :slug

      t.timestamps
    end

    add_index :raddar_pages, :slug, unique: true
  end
end
