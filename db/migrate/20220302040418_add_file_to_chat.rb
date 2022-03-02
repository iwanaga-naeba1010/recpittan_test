class AddFileToChat < ActiveRecord::Migration[6.1]
  def change
    add_column :chats, :file, :text
  end
end
