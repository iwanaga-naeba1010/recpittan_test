# frozen_string_literal: true

class OrderConfigSerializer
  def serialize(years:, months:, days:, hours:, minutes:)
    {
      years: years,
      months: months,
      days: days,
      hours: hours,
      minutes: minutes
    }
  end
end
