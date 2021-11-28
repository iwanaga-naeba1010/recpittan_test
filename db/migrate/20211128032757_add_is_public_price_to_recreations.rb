class AddIsPublicPriceToRecreations < ActiveRecord::Migration[6.1]
  def change
    add_column :recreations, :is_public_price, :boolean, default: true
  end
end
