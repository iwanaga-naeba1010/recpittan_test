class AddIsOpenToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :is_open, :boolean, default: true, null: false
  end
end
