class CreateUserRecreationRecreationPlans < ActiveRecord::Migration[7.0]
  def up
    create_table :user_recreation_recreation_plans do |t|
      t.references :recreation, null: false, foreign_key: true, index: { name: 'index_user_rec_rec_plans_on_rec_id' }
      t.references :user_recreation_plan, null: false, foreign_key: true, index: { name: 'index_user_rec_rec_plans_on_user_rec_plan_id' }
      t.integer :month

      t.timestamps
    end
  end
end
