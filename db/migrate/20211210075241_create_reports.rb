class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.references :order, null: false, foreign_key: true
      t.boolean :is_accepted
      t.integer :facility_count
      t.integer :number_of_people
      t.integer :transportation_expenses
      t.integer :expenses
      t.text :body

      t.timestamps
    end
  end
end
