class AddContractNumberToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :contract_number, :string
  end
end
