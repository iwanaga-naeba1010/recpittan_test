class CreateRecreationProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :recreation_profiles do |t|
      t.references :recreation, null: false, foreign_key: true
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
