class AddContactFieldsToClients < ActiveRecord::Migration
  def change
    add_column :clients, :contact, :string
    add_column :clients, :street, :string
    add_column :clients, :city, :string
    add_column :clients, :state, :string
    add_column :clients, :zip, :string
    add_column :clients, :phone, :string
    add_column :clients, :email, :string
  end
end
