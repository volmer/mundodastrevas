class RenamePostTaggings < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        Raddar::Tagging.where(taggable_type: 'Raddar::Zines::Post')
          .update_all(taggable_type: 'Post')
      end

      dir.down do
        Raddar::Tagging.where(taggable_type: 'Post')
          .update_all(taggable_type: 'Raddar::Zines::Post')
      end
    end
  end
end
