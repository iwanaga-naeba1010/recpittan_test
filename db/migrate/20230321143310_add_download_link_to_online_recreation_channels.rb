class AddDownloadLinkToOnlineRecreationChannels < ActiveRecord::Migration[7.0]
  def change
    add_column :online_recreation_channels, :calendar_pdf, :text
    add_column :online_recreation_channels, :calendar_ppt, :text
    add_column :online_recreation_channels, :flyer_pdf, :text
    add_column :online_recreation_channels, :flyer_ppt, :text
  end
end
