class AddActiveToPlacements < ActiveRecord::Migration
  def change
    add_column :placements, :active, :boolean, default: true, null: false
  end
end
