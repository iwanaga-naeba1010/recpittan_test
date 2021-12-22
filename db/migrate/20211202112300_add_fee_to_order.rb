class AddFeeToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :transportation_expenses, :integer
    add_column :orders, :expenses, :integer
  end
end
