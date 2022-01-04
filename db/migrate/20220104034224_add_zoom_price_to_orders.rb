class AddZoomPriceToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :zoom_price, :integer, default: 0
  end
end
