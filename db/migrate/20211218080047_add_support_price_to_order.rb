class AddSupportPriceToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :support_price, :integer, default: 0
    change_column :orders, :expenses, :integer, default: 0
    change_column :orders, :transportation_expenses, :integer, default: 0
  end
end
