class ChangePriceColumnNameToRecAndOrder < ActiveRecord::Migration[7.0]
  def change
    rename_column :recreations, :regular_price, :price
    rename_column :recreations, :regular_material_price, :material_price
    rename_column :recreations, :instructor_amount, :amount
    rename_column :recreations, :instructor_material_amount, :material_amount


    rename_column :orders, :regular_price, :price
    rename_column :orders, :regular_material_price, :material_price
    rename_column :orders, :instructor_amount, :amount
    rename_column :orders, :instructor_material_amount, :material_amount
  end
end
