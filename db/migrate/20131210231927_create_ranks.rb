class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.string :name
      t.text :description
      t.references :universe, index: true
      t.integer :value

      t.timestamps
    end

    add_index :ranks, [:value, :universe_id], unique: true
    add_index :ranks, :value
  end
end
