class AddZipToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :zip, :string
    add_column :orders, :street, :string
    add_column :orders, :building, :string
  end
end
