class CreateStockings < ActiveRecord::Migration
  def change
    create_table :stockings do |t|
      t.date :stocked_on, null: false
      t.belongs_to :placement, index: true, null: false
      t.integer :quantity, null: false
      t.timestamps
    end
  end
end
