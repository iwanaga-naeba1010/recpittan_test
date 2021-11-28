class AddColumnsToCompany < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :address, :string
    add_column :companies, :phone, :string
    add_column :companies, :region, :string
    add_column :companies, :locality, :string
  end
end
