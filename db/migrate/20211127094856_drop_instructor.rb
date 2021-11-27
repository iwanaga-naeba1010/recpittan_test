class DropInstructor < ActiveRecord::Migration[6.1]
  def change
    add_column :recreations, :instructor_name, :string
    add_column :recreations, :instructor_title, :string
    add_column :recreations, :instructor_description, :text
    add_column :recreations, :instructor_image, :text

    drop_table :instructors
  end
end
