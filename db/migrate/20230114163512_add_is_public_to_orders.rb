class AddIsPublicToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :is_public, :boolean, default: true, null: false
  end
end
