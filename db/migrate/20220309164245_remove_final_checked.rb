class RemoveFinalChecked < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :is_final_checked
  end
end
