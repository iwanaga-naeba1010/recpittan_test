class CreateRecreationPlanTags < ActiveRecord::Migration[7.0]
  def change
    create_table :recreation_plan_tags do |t|
      t.references :recreation_plan, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
