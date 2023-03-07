# frozen_string_literal: true

module OnlineRecChannelHelper
  def channel_id
    channels = OnlineRecChannel.where(status: :public)
    channels.find_by("to_char(period, 'YYYY-MM') = ?", Time.zone.today.strftime('%Y-%m')).id || channels.last.id
  end
end
