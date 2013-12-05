# This migration comes from raddar_forums (originally 20131116161231)
class CreateRaddarForumsTopics < ActiveRecord::Migration
  def change
    create_table :raddar_forums_topics do |t|
      t.string :name
      t.integer :views, default: 0
      t.references :forum, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
