class DropOrderTagModel < ActiveRecord::Migration[6.1]
  def change
    drop_table :order_tags
  end
end
