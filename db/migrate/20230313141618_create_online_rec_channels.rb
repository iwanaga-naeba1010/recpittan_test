class CreateOnlineRecChannels < ActiveRecord::Migration[7.0]
  def change
    create_table :online_rec_channels do |t|
      t.text :image
      t.integer :status, null: false
      t.date :period, null: false
      t.text :calendar_field_memo
      t.text :zoom_field_memo

      t.timestamps
    end
  end
end
