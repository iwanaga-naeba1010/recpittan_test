class CreateRecreationTags < ActiveRecord::Migration[6.1]
  def change
    create_table :recreation_tags do |t|
      t.references :recreation, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
