# frozen_string_literal: true

module OnlineRecreationChannelHelper
  def formatted_period(period)
    period.strftime('%-m月')
  end

  # TODO: 8月以降に消す
  def formatted_date(date)
    "#{date.strftime('%-d日')}(#{WeekDay.all[date.wday]})"
  end

  def formatted_datetime(datetime)
    "#{datetime.strftime('%-d日')}(#{WeekDay.all[datetime.wday]}) #{datetime.strftime('%H:%M')} 〜"
  end

  # TODO: リファクタリング
  def sanitize_link(link)
    sanitized_link = link.gsub(%r{(https?://\S+)}, '<a href="\1" target="_blank" rel="noopener">レク詳細はこちら</a>')
    sanitize(sanitized_link, tags: %w[a], attributes: %w[href target rel])
  end

  def sanitize_text_link(text)
    text.gsub(URI::DEFAULT_PARSER.make_regexp(%w[http https])) do |url|
      "<a href=\"#{url}\" target=\"_blank\" rel=\"noopener\">#{url}</a>"
    end
  end
end
