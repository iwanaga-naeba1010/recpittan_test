class CreateBankAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :bank_accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :bank_name, null: false
      t.string :bank_code, null: false
      t.string :branch_name, null: false
      t.string :branch_code, null: false
      t.string :account_type, null: false
      t.string :account_number, null: false
      t.string :account_holder_name, null: false

      t.timestamps
    end

    add_index :bank_accounts, [:user_id, :account_number], unique: true
  end
end
