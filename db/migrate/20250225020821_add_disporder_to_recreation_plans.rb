class AddDisporderToRecreationPlans < ActiveRecord::Migration[7.2]
  def change
    add_column :recreation_plans, :disporder, :integer, default: 0
  end
end
