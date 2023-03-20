# frozen_string_literal: true

module OnlineRecreationChannelHelper
  def channel_id
    channels = OnlineRecreationChannel.public_channels.current_month
    channels.exists? ? channels.first.id : OnlineRecreationChannel.last.id
  end

  def formatted_period(period)
    period.strftime('%-m月')
  end

  def formatted_date(date)
    "#{date.strftime('%-d日')}(#{WeekDay.all[date.wday]})"
  end

  def sanitize_link(link)
    sanitize(link.gsub(%r{(https?://\S+)}, '<a href="\1" target="_blank">\1</a>'))
  end
end
