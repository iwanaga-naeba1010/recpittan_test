class RemovePriceFromRecreation < ActiveRecord::Migration[6.1]
  def change
    remove_column :recreations, :price
  end
end
