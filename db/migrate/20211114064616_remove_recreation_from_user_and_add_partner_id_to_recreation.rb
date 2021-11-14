class RemoveRecreationFromUserAndAddPartnerIdToRecreation < ActiveRecord::Migration[6.1]
  def change
    remove_column :recreations, :user_id
    add_reference :recreations, :partner, null: false, foreign_key: true
  end
end
