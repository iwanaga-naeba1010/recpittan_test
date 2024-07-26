class CreatePartnerInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :partner_infos do |t|
      t.references :user, null: false, foreign_key: true
      t.string :phone_number
      t.string :postal_code
      t.string :prefecture
      t.string :city
      t.string :address1
      t.string :address2
      t.string :company_name

      t.timestamps
    end
  end
end
