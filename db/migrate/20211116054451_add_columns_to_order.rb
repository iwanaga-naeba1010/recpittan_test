class AddColumnsToOrder < ActiveRecord::Migration[6.1]
  def change
    rename_column :orders, :order_type, :status
    add_column :orders, :is_online, :boolean, default: false
    add_column :orders, :is_accepted, :boolean, default: false
    add_column :orders, :date_and_time, :datetime
  end
end
