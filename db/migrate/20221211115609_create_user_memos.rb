class CreateUserMemos < ActiveRecord::Migration[7.0]
  def change
    create_table :user_memos do |t|
      t.references :user, null: false, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
