class CreateRecreationImages < ActiveRecord::Migration[6.1]
  def change
    create_table :recreation_images do |t|
      t.references :recreation, null: false, foreign_key: true
      t.text :image

      t.timestamps
    end
  end
end
