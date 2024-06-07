class AddAdjustmentFeeToRecreationPlans < ActiveRecord::Migration[7.0]
  def change
    add_column :recreation_plans, :adjustment_fee, :integer
  end
end
