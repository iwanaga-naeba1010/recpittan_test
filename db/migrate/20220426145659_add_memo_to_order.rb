class AddMemoToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :memo, :string
  end
end
