class DropPartner < ActiveRecord::Migration[6.1]
  def change
    remove_column :recreations, :partner_id

    drop_table :partners
    add_reference :recreations, :user, null: false, foreign_key: true
  end
end
