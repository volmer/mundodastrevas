# This migration comes from raddar (originally 20131115231153)
class EnableExtensionUnaccent < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        enable_extension 'unaccent'
      end

      dir.down do
        disable_extension 'unaccent'
      end
    end
  end
end
