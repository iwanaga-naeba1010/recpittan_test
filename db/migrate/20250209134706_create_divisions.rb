class CreateDivisions < ActiveRecord::Migration[7.2]
  def change
    create_table :divisions do |t|
      t.string :classname
      t.string :code
      t.string :valuetext
      t.integer :valueint
      t.datetime :valuedate
      t.integer :disporder
      t.text :memo
      t.string :key
      t.boolean :i18n_flag
      t.string :i18n_class

      t.timestamps
    end
  end
end
