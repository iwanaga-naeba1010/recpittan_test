class AddBaseCodeToRecreation < ActiveRecord::Migration[6.1]
  def change
    add_column :recreations, :base_code, :string
  end
end
