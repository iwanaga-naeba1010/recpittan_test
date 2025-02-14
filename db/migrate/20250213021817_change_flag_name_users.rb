class ChangeFlagNameUsers < ActiveRecord::Migration[7.2]
  def change
    rename_column :users, :facility_flag, :is_facility
    rename_column :users, :partner_flag, :is_partner
    rename_column :users, :mfa_enabled_flag, :is_mfa_enabled
  end
end
