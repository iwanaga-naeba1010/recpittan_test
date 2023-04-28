class RemoveImagesFromOnlineRecreationChannels < ActiveRecord::Migration[7.0]
  def change
    remove_column :online_recreation_channels, :calendar_image, :text
    remove_column :online_recreation_channels, :calendar_pdf, :text
    remove_column :online_recreation_channels, :flyer_pdf, :text
    remove_column :online_recreation_channels, :flyer_image, :text
  end
end
