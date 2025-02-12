class AddFieldsToCompanies < ActiveRecord::Migration[7.2]
  def change
    add_column :companies, :trading_target_code, :string, null: true
    add_column :companies, :pref_code, :string, null: true
    add_column :companies, :manage_company_code, :string, null: true
    add_column :companies, :common_trading_target_code, :string, null: true
  end
end
