# This migration comes from raddar_zines (originally 20131203124943)
class CreateRaddarComments < ActiveRecord::Migration
  def change
    create_table :raddar_zines_comments do |t|
      t.references :user, index: true
      t.references :post, index: true
      t.text :content

      t.timestamps
    end
  end
end
