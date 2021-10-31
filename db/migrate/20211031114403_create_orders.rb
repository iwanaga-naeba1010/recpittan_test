class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :recreation, null: false, foreign_key: true
      t.integer :number_of_people
      t.integer :order_type
      t.string :prefecture
      t.string :city

      t.timestamps
    end
  end
end
