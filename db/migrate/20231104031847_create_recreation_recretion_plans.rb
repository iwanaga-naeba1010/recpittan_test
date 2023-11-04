class CreateRecreationRecretionPlans < ActiveRecord::Migration[7.0]
  def change
    create_table :recreation_recretion_plans do |t|
      t.references :recreation, null: false, foreign_key: true
      t.references :recreation_plan, null: false, foreign_key: true
      t.integer :month

      t.timestamps
    end

    execute <<-SQL
      ALTER TABLE recreation_recretion_plans
      ADD CONSTRAINT check_month
      CHECK (month >= 1 AND month <= 12);
    SQL
  end
end
