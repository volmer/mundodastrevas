class AddUniverseToRaddarZinesZines < ActiveRecord::Migration
  def change
    add_reference :raddar_zines_zines, :universe, index: true
  end
end
