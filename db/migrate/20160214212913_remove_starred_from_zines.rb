class RemoveStarredFromZines < ActiveRecord::Migration
  def change
    remove_column :zines, :starred, :boolean
  end
end
