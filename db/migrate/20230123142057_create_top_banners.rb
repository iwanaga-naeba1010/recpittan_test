class CreateTopBanners < ActiveRecord::Migration[7.0]
  def change
    create_table :top_banners do |t|
      t.string :image, null: false
      t.string :url
      t.date :start_date, null: false
      t.date :end_date, null: false

      t.timestamps
    end
  end
end
