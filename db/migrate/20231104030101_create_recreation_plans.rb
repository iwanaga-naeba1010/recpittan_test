class CreateRecreationPlans < ActiveRecord::Migration[7.0]
  def change
    create_table :recreation_plans do |t|
      t.string :title, null: false
      t.string :code, null: false
      t.integer :release_status, null: false, default: 0

      t.timestamps
    end

    add_index :recreation_plans, :code, unique: true
  end
end
