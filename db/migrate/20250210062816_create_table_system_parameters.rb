class CreateTableSystemParameters < ActiveRecord::Migration[7.2]
  def change
    create_table :system_parameters do |t|
      t.string :param_code
      t.string :param_name
      t.decimal :value_int, precision: 15, scale: 4, null: true
      t.string :value_text
      t.datetime :applied_date

      t.timestamps
    end
  end
end
