class RemoveTextAndImageFromTag < ActiveRecord::Migration[6.1]
  def change
    remove_column :tags, :image
    remove_column :tags, :text
  end
end
