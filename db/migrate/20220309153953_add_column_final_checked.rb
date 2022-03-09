class AddColumnFinalChecked < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :is_final_checked, :boolean, default: false
  end
end
