class CreateBrochureRacks < ActiveRecord::Migration
  def change
    create_table :brochure_racks do |t|
      t.string :name
      t.integer :number_of_rows
      t.integer :number_of_columns

      t.timestamps
    end
  end
end
