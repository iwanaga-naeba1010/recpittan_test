class AddPriceToRecreation < ActiveRecord::Migration[6.1]
  def change
    add_column :recreations, :price, :integer, null: false, default: 0
  end
end
