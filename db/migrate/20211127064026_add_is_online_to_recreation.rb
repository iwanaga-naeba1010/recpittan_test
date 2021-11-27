class AddIsOnlineToRecreation < ActiveRecord::Migration[6.1]
  def change
    add_column :recreations, :is_online, :boolean, default: false
  end
end
