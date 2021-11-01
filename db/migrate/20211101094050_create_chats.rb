class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.references :order, null: false, foreign_key: true
      t.text :message
      t.boolean :is_read
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
