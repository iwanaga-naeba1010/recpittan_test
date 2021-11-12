class AddTextToTags < ActiveRecord::Migration[6.1]
  def change
    add_column :tags, :text, :text
    add_column :tags, :image, :text
  end
end
