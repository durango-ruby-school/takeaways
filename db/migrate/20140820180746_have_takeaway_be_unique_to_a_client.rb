class HaveTakeawayBeUniqueToAClient < ActiveRecord::Migration
  def change
    add_index :takeaways, [:name, :client_id], unique: true
  end
end
