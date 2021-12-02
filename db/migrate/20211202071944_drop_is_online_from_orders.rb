class DropIsOnlineFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :is_online
  end
end
