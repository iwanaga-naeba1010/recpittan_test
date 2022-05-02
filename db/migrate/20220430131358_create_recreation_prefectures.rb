class CreateRecreationPrefectures < ActiveRecord::Migration[7.0]
  def change
    create_table :recreation_prefectures do |t|
      t.references :recreation, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
