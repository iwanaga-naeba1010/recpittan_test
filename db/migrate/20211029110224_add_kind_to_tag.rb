class AddKindToTag < ActiveRecord::Migration[6.1]
  def change
    add_column :tags, :kind, :integer
  end
end
