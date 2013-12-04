# This migration comes from raddar (originally 20131101194411)
class CreateRaddarMessages < ActiveRecord::Migration
  def change
    create_table :raddar_messages do |t|
      t.references :sender, index: true
      t.references :recipient, index: true
      t.boolean :read, default: false
      t.text :content

      t.timestamps
    end
  end
end
