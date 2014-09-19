class AddUniqueIndexToBrochureRackName < ActiveRecord::Migration
  def change
    add_index :brochure_racks, :name, unique: true
  end
end
