class AddFieldsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :mfa_enabled_flag, :boolean, default: false, null: false
    add_column :users, :mfa_authenticated_at, :datetime, null: true
    add_column :users, :partner_flag, :boolean, default: false, null: true
    add_column :users, :facility_flag, :boolean, default: false, null: true
    add_column :users, :manage_company_code, :string, null: true
  end
end
