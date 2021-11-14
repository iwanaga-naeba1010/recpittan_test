class RemoveUserIdFromCompanyAndAddCompanyIdToUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :companies, :user_id
    add_reference :users, :company, null: true, foreign_key: true
  end
end
