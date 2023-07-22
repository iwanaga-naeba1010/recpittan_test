class AddDatetimeToOnlineRecreationChannelRecreation < ActiveRecord::Migration[7.0]
  def change
    add_column :online_recreation_channel_recreations, :datetime, :datetime, null: false
    change_column_null :online_recreation_channel_recreations, :date, true
  end
end
