# This migration comes from raddar (originally 20131020174318)
class CreateRaddarRoles < ActiveRecord::Migration
  def change
    create_table :raddar_roles do |t|
      t.string :name

      t.timestamps
    end

    add_index :raddar_roles, :name, unique: true
  end
end
