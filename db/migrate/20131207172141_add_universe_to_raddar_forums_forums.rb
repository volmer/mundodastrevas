class AddUniverseToRaddarForumsForums < ActiveRecord::Migration
  def change
    add_reference :raddar_forums_forums, :universe, index: true
  end
end
