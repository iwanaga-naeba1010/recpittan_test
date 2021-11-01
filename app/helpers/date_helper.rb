# frozen_string_literal: true

module DateHelper
  def dotted_datetime(datetime)
    return if datetime.blank?

    datetime.strftime('%Y.%m.%d %H:%M')
  end

  def date(datetime)
    return '' if datetime.blank?

    datetime.strftime('%Y年%m月%d日')
  end

  def time(datetime)
    return '' if datetime.blank?

    datetime.strftime('%H:%M')
  end
end
