class CreateInstructors < ActiveRecord::Migration[6.1]
  def change
    create_table :instructors do |t|
      t.references :recreation, null: false, foreign_key: true
      t.string :name
      t.string :title
      t.text :description
      t.text :image

      t.timestamps
    end
  end
end
