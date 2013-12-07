# This migration comes from raddar_zines (originally 20131130172115)
class CreateRaddarZines < ActiveRecord::Migration
  def change
    create_table :raddar_zines_zines do |t|
      t.string :name
      t.references :user, index: true
      t.text :description
      t.boolean :starred, default: false
      t.string :image
      t.string :slug

      t.timestamps
    end

    add_index :raddar_zines_zines, :slug, unique: true
  end
end
