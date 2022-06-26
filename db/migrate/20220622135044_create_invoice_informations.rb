class CreateInvoiceInformations < ActiveRecord::Migration[7.0]
  def change
    create_table :invoice_informations do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :code
      t.string :zip, null: false
      t.string :prefecture, null: false
      t.string :city, null: false
      t.string :street, null: false
      t.string :building
      t.string :memo

      t.timestamps
    end
  end
end
