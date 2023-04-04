class CreateOnlineRecreationChannelRecreations < ActiveRecord::Migration[7.0]
  def change
    create_table :online_recreation_channel_recreations do |t|
      t.references :online_recreation_channel, null: false, foreign_key: true, index: {name: :index_channel_recreations_on_channel_id}
      t.string :title, null: false, foreign_key: true
      t.text :link, null: false, foreign_key: true
      t.text :memo, foreign_key: true
      t.date :date, null: false
      t.text :zoom_link

      t.timestamps
    end

    add_index  :online_recreation_channel_recreations, [:online_recreation_channel_id, :date], unique: true, name: :index_channel_recreations_on_channel_date
  end
end
