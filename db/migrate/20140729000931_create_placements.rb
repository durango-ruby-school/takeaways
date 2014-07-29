class CreatePlacements < ActiveRecord::Migration
  def change
    create_table :placements do |t|
      t.belongs_to :brochure_rack, index: true, null: false
      t.belongs_to :takeaway, index: true, null: false

      t.timestamps
    end
  end
end
