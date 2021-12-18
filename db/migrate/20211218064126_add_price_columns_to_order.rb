class AddPriceColumnsToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :regular_price, :integer, default: 0
    add_column :orders, :instructor_amount, :integer, default: 0
    add_column :orders, :regular_material_price, :integer, default: 0
    add_column :orders, :instructor_material_amount, :integer, default: 0
    add_column :orders, :additional_facility_fee, :integer, default: 0
  end
end
