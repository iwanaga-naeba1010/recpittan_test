class AddCategoryToRecreation < ActiveRecord::Migration[7.0]
  def change
    add_column :recreations, :category, :integer, null: false, default: 0
  end
end
