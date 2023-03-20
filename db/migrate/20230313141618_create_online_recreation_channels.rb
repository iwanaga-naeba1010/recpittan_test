class CreateOnlineRecreationChannels < ActiveRecord::Migration[7.0]
  def change
    create_table :online_recreation_channels do |t|
      t.text :image
      t.integer :status, null: false
      t.date :period, null: false
      t.text :calendar_memo
      t.text :zoom_memo

      t.timestamps
    end
  end
end
