class CreateUniverses < ActiveRecord::Migration
  def change
    create_table :universes do |t|
      t.string :name
      t.text :description
      t.string :slug
      t.string :image

      t.timestamps
    end

    add_index :universes, :slug, unique: true
  end
end
