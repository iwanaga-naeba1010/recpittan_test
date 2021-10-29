class CreateRecreations < ActiveRecord::Migration[6.1]
  def change
    create_table :recreations do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :second_title
      t.integer :minutes
      t.text :description
      t.text :flow_of_day
      t.text :borrow_item
      t.text :bring_your_own_item
      t.text :extra_information

      t.timestamps
    end
  end
end
