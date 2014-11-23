# This migration comes from raddar (originally 20141030202154)
class CreateRaddarActivities < ActiveRecord::Migration
  def change
    create_table :raddar_activities do |t|
      t.references :subject, polymorphic: true, index: true
      t.references :user, index: true
      t.string :key
      t.hstore :parameters
      t.string :privacy

      t.timestamps
    end
  end
end
