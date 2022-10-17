class AddColumnMemosForRecreation < ActiveRecord::Migration[7.0]
  def change
    add_column :recreations, :memo, :string

    add_column :users, :memo, :string

    add_column :companies, :memo, :string
  end
end
