class CreateOrderDesireDates < ActiveRecord::Migration[7.2]
  def change
    create_table :order_desire_dates do |t|
      t.references :order, null: false, foreign_key: true
      t.integer :desire_no
      t.date :desire_date
      t.time :time_from
      t.time :time_to

      t.timestamps
    end
  end
end
