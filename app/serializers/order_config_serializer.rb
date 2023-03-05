# frozen_string_literal: true

class OrderConfigSerializer
  def serialize(years:, months:, days:, hours:, minutes:)
    {
      years:,
      months:,
      days:,
      hours:,
      minutes:
    }
  end
end
