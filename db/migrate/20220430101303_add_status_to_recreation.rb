class AddStatusToRecreation < ActiveRecord::Migration[7.0]
  def change
    add_column :recreations, :status, :integer, null: false, default: 0
  end
end
