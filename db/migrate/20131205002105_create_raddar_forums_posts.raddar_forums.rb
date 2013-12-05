# This migration comes from raddar_forums (originally 20131116193222)
class CreateRaddarForumsPosts < ActiveRecord::Migration
  def change
    create_table :raddar_forums_posts do |t|
      t.text :content
      t.references :user, index: true
      t.references :topic, index: true

      t.timestamps
    end
  end
end
