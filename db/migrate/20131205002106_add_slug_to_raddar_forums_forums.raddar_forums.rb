# This migration comes from raddar_forums (originally 20131117184633)
class AddSlugToRaddarForumsForums < ActiveRecord::Migration
  def change
    add_column :raddar_forums_forums, :slug, :string

    add_index :raddar_forums_forums, :slug, unique: true
  end
end
