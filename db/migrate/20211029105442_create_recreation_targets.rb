class CreateRecreationTargets < ActiveRecord::Migration[6.1]
  def change
    create_table :recreation_targets do |t|
      t.references :recreation, null: false, foreign_key: true
      t.references :target, null: false, foreign_key: true

      t.timestamps
    end
  end
end
