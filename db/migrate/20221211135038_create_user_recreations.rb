class CreateUserRecreations < ActiveRecord::Migration[7.0]
  def change
    create_table :user_recreations do |t|
      t.references :recreation, null: false, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
