class AddColumsToBankAccount < ActiveRecord::Migration[7.2]
  def change
    add_column :bank_accounts, :is_corporate, :boolean, default: false, null: true
    add_column :bank_accounts, :corporate_type_code, :string, null: true
    add_column :bank_accounts, :is_foreignresident, :boolean, default: false, null: true
    add_column :bank_accounts, :investments, :integer, null: true
    add_column :bank_accounts, :is_invoice, :boolean, default: false, null: true
    add_column :bank_accounts, :invoice_number, :string, null: true
    add_column :bank_accounts, :corporate_number, :string, null: true
    add_column :bank_accounts, :my_number, :string, null: true
    add_column :bank_accounts, :is_subcontract, :boolean, default: false, null: true
  end
end
