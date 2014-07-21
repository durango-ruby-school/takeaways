class CreateTakeaways < ActiveRecord::Migration
  def change
    create_table :takeaways do |t|
      t.string :name, null: false
      t.belongs_to :client, index: true, null: false

      t.timestamps
    end
  end
end
