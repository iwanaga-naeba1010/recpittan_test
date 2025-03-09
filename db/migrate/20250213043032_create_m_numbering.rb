class CreateMNumbering < ActiveRecord::Migration[7.2]
  def change
    create_table :m_numberings do |t|
      t.string :numbering_name, null: false
      t.string :numbering_unit, null: false
      t.text :numbering_datetime, null: true
      t.string :code_name, null: false
      t.string :code, null: false
      t.integer :numbering_value, null: false

      t.timestamps
    end

    add_index :m_numberings, [:numbering_name, :numbering_unit, :numbering_datetime, :code], unique: true
  end
end
