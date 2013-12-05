# This migration comes from raddar_forums (originally 20131116152306)
class CreateRaddarForumsForums < ActiveRecord::Migration
  def change
    create_table :raddar_forums_forums do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
