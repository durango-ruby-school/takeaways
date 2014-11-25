class AddActiveToTakeaways < ActiveRecord::Migration
  def change
    add_column :takeaways, :active, :boolean, default: true, null: false
  end
end
