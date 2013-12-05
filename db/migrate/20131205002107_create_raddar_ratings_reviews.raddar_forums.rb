# This migration comes from raddar_forums (originally 20131123020223)
class CreateRaddarRatingsReviews < ActiveRecord::Migration
  def change
    create_table :raddar_ratings_reviews do |t|
      t.references :user, index: true
      t.string :value
      t.references :reviewable, polymorphic: true

      t.timestamps
    end

    add_index :raddar_ratings_reviews,
      [:reviewable_id, :reviewable_type],
      name: 'index_raddar_ratings_reviews_reviewable'

    add_index :raddar_ratings_reviews,
      [:user_id, :reviewable_id, :reviewable_type],
      unique: true,
      name: 'index_raddar_ratings_reviews_unique_user'
  end
end
