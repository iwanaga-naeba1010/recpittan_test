class DropPlanAndRemoveUnnecesaryColumns < ActiveRecord::Migration[6.1]
  def change
    drop_table :plans
    remove_column :companies, :locality
    remove_column :companies, :region
    remove_column :companies, :phone
  end
end
