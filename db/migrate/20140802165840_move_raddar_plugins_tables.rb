class MoveRaddarPluginsTables < ActiveRecord::Migration
  def up
    execute 'INSERT INTO raddar_tags SELECT * FROM raddar_tags_tags'
    execute 'INSERT INTO raddar_taggings SELECT * FROM raddar_tags_taggings'
    execute 'INSERT INTO raddar_watches SELECT * FROM raddar_watchers_watches'
    execute 'INSERT INTO raddar_reviews SELECT * FROM raddar_ratings_reviews'

    drop_table :raddar_tags_tags
    drop_table :raddar_tags_taggings
    drop_table :raddar_watchers_watches
    drop_table :raddar_ratings_reviews
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
