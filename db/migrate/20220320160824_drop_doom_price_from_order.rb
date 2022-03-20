class DropDoomPriceFromOrder < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :zoom_price
  end
end
