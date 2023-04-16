class CreateOnlineRecreationChannelDownloadImages < ActiveRecord::Migration[7.0]
  def change
    create_table :online_recreation_channel_download_images do |t|
      t.text :image, null: false
      t.integer :kind, null: false
      t.references :online_recreation_channel, null: false, foreign_key: true, foreign_key: true, index: { name: 'index_online_recreation_channel_dw_images_on_channel_id' }

      t.timestamps
    end

    add_index :online_recreation_channel_download_images, [:online_recreation_channel_id, :kind], unique: true, name: 'index_channel_dw_images_on_channel_id_and_kind'
  end
end
