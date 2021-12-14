class CreateEvaluations < ActiveRecord::Migration[6.1]
  def change
    create_table :evaluations do |t|
      t.references :report, null: false, foreign_key: true
      t.integer :ingenuity
      t.integer :communication
      t.integer :smoothness
      t.integer :price
      t.integer :want_to_order_agein
      t.text :message
      t.text :other_message

      t.timestamps
    end
  end
end
