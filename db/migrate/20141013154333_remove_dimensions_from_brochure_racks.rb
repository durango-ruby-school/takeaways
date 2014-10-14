class RemoveDimensionsFromBrochureRacks < ActiveRecord::Migration
  def change
    remove_column :brochure_racks, :number_of_rows, :integer
    remove_column :brochure_racks, :number_of_columns, :integer
  end
end
