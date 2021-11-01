class RemoveColumnsFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :name
    remove_column :users, :name_kana
    remove_column :users, :company_name
    remove_column :users, :facility_name
  end
end
