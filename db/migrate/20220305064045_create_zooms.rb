class CreateZooms < ActiveRecord::Migration[6.1]
  def change
    create_table :zooms do |t|
      t.references :order, null: false, foreign_key: true
      t.integer :price, default: 0
      t.integer :created_by
      t.string :url

      t.timestamps
    end
  end
end
