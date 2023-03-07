class CreateOnlineRecChannelRecreations < ActiveRecord::Migration[7.0]
  def change
    create_table :online_rec_channel_recreations do |t|
      t.references :online_rec_channel, null: false, foreign_key: true
      t.string :recreation_title, null: false, foreign_key: true
      t.text :recreation_link, null: false, foreign_key: true
      t.text :recreation_memo, foreign_key: true
      t.date :date, null: false
      t.text :zoom_link

      t.timestamps
    end

    add_index  :online_rec_channel_recreations, [:online_rec_channel_id, :date], unique: true, name: :index_online_rec_channel_recs_on_online_rec_channel_date
  end
end
