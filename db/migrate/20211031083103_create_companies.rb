class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :facility_name
      t.string :person_in_charge_name
      t.string :person_in_charge_name_kana
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
