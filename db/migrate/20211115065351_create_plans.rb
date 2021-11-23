class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans do |t|
      t.references :company, null: false, foreign_key: true
      t.integer :kind

      t.timestamps
    end
  end
end
