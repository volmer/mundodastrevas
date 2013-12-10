class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.references :user, index: true
      t.references :universe, index: true
      t.integer :value

      t.timestamps
    end

    add_index :levels, :value
    add_index :levels, [:user_id, :universe_id], unique: true
  end
end
