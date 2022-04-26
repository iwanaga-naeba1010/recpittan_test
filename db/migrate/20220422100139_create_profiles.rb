class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :title
      t.text :description
      t.text :image
      t.string :position

      t.timestamps
    end
  end
end
