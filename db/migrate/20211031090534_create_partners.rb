class CreatePartners < ActiveRecord::Migration[6.1]
  def change
    create_table :partners do |t|
      t.string :name
      t.string :title
      t.text :description
      t.text :image
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
