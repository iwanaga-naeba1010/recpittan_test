class CreateOrderDates < ActiveRecord::Migration[6.1]
  def change
    create_table :order_dates do |t|
      t.references :order, null: false, foreign_key: true
      t.integer :year
      t.integer :month
      t.integer :date
      t.integer :start_hour
      t.integer :start_minute
      t.integer :end_hour
      t.integer :end_minute
      t.timestamps
    end
  end
end
