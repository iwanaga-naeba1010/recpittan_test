class AddAvailableUserToRecreationPlans < ActiveRecord::Migration[7.0]
  def change
    add_reference :recreation_plans, :available_user, foreign_key: { to_table: :users }
  end
end
