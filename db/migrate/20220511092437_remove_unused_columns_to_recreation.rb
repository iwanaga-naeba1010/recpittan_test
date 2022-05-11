class RemoveUnusedColumnsToRecreation < ActiveRecord::Migration[7.0]
  def change
    remove_column :recreations, :is_online
    remove_column :recreations, :is_public
    remove_column :recreations, :instructor_name
    remove_column :recreations, :instructor_position
    remove_column :recreations, :instructor_description
    remove_column :recreations, :instructor_title
    remove_column :recreations, :instructor_image
  end
end
