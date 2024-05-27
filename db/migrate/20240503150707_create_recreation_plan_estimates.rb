class CreateRecreationPlanEstimates < ActiveRecord::Migration[7.0]
  def change
    create_table :recreation_plan_estimates do |t|
      t.string :estimate_number, null: false
      t.integer :start_month, null: false
      t.integer :transportation_expenses, null: false
      t.integer :number_of_people, null: false
      t.references :recreation_plan, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :recreation_plan_estimates, [:user_id, :estimate_number], unique: true
  end
end
