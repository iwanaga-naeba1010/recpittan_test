class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :zip, :string
    add_column :companies, :prefecture, :string
    add_column :companies, :city, :string
    add_column :companies, :street, :string
    add_column :companies, :building, :string
    add_column :companies, :tel, :string
  end
end
