class AddUniquenessConstraintToPlacements < ActiveRecord::Migration
  def change
    add_index :placements, [:brochure_rack_id, :takeaway_id], unique: true
  end
end
