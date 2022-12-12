class CreateRecreationMemos < ActiveRecord::Migration[7.0]
  def change
    create_table :recreation_memos do |t|
      t.references :recreation, null: false, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
