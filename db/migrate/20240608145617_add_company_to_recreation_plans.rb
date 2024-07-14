class AddCompanyToRecreationPlans < ActiveRecord::Migration[7.0]
  def change
    add_reference :recreation_plans, :company
  end
end
