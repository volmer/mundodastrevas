# This migration comes from raddar (originally 20140802033859)
class CreateRaddarReviews < ActiveRecord::Migration
  def change
    create_table :raddar_reviews do |t|
      t.references :user, index: true
      t.string :value
      t.references :reviewable, polymorphic: true

      t.timestamps
    end

    add_index :raddar_reviews,
      [:reviewable_id, :reviewable_type],
      name: 'index_raddar_reviews_reviewable'

    add_index :raddar_reviews,
      [:user_id, :reviewable_id, :reviewable_type],
      unique: true,
      name: 'index_raddar_reviews_unique_user'
  end
end
