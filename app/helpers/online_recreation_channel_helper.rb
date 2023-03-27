# frozen_string_literal: true

module OnlineRecreationChannelHelper
  def channel_id
    channels = OnlineRecreationChannel.public_channels
    channels.exists? ? channels.current_month.first&.id || channels.last&.id : nil
  end

  def formatted_period(period)
    period.strftime('%-m月')
  end

  def formatted_date(date)
    "#{date.strftime('%-d日')}(#{WeekDay.all[date.wday]})"
  end

  # TODO: リファクタリング
  def sanitize_link(link)
    sanitize(link.gsub(%r{(https?://\S+)}, '<a href="\1" target="_blank">レク詳細はこちら</a>'))
  end

  def sanitize_pdf_link(link)
    sanitize(link.gsub(%r{(https?://\S+)}, '<a href="\1" target="_blank">PDF</a>'))
  end

  def sanitize_ppt_link(link)
    sanitize(link.gsub(%r{(https?://\S+)}, '<a href="\1" target="_blank">PNG</a>'))
  end

  def sanitize_text_link(link)
    sanitize(link.gsub(%r{(https?://\S+)}, '<a href="\1" target="_blank">\1</a>'))
  end
end
