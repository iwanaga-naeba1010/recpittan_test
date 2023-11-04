class CreateUserRecreationPlans < ActiveRecord::Migration[7.0]
  def change
    create_table :user_recreation_plans do |t|
      t.string :title, null: false
      t.string :code, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :user_recreation_plans, :code, unique: true
  end
end
