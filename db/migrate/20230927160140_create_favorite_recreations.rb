class CreateFavoriteRecreations < ActiveRecord::Migration[7.0]
  def change
    create_table :favorite_recreations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :recreation, null: false, foreign_key: true

      t.timestamps
    end

    add_index :favorite_recreations, [:user_id, :recreation_id], unique: true
  end
end
