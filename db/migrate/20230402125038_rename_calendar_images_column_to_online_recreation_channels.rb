class RenameCalendarImagesColumnToOnlineRecreationChannels < ActiveRecord::Migration[7.0]
  def change
    rename_column :online_recreation_channels, :image, :top_image
    rename_column :online_recreation_channels, :calendar_ppt, :calendar_image
    rename_column :online_recreation_channels, :flyer_ppt, :flyer_image
  end
end
