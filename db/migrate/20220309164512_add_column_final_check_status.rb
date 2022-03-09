class AddColumnFinalCheckStatus < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :final_check_status, :integer
  end
end
