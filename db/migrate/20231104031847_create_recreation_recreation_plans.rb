class CreateRecreationRecreationPlans < ActiveRecord::Migration[7.0]
  def up
    create_table :recreation_recreation_plans do |t|
      t.references :recreation, null: false, foreign_key: true
      t.references :recreation_plan, null: false, foreign_key: true
      t.integer :month

      t.timestamps
    end
  end
end
