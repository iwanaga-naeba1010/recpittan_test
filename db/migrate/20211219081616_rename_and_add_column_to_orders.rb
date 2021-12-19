class RenameAndAddColumnToOrders < ActiveRecord::Migration[6.1]
  def change
    rename_column :orders, :date_and_time, :start_at
    add_column :orders, :end_at, :datetime
  end
end
