# frozen_string_literal: true

# == Schema Information
#
# Table name: order_dates
#
#  id           :bigint           not null, primary key
#  date         :string
#  end_hour     :string
#  end_minute   :string
#  month        :string
#  start_hour   :string
#  start_minute :string
#  year         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  order_id     :bigint           not null
#
# Indexes
#
#  index_order_dates_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#
class OrderDate < ApplicationRecord
  belongs_to :order, class_name: 'Order'

  validate :check_dates

  private

  # rubocop:disable Style/CaseEquality, Metrics/AbcSize
  def check_dates
    d = self
    date_ary = [d.year, d.month, d.date, d.start_hour, d.start_minute, d.end_hour, d.end_minute]
    if date_ary.reject(&:empty?).length === 7
      start_at = Time.zone.local(d.year.to_i, d.month.to_i, d.date.to_i, d.start_hour.to_i, d.start_minute.to_i)
      end_at = Time.zone.local(d.year.to_i, d.month.to_i, d.date.to_i, d.end_hour.to_i, d.end_minute.to_i)
    end
    date_ary.reject(&:empty?)
    if (!date_ary.reject(&:empty?).empty? && date_ary.reject(&:empty?).length < 7) || start_at < Time.zone.now || end_at < start_at
      errors.add(:order_dates, '開催の希望日が無効な日付です。ご確認のうえ、もう一度入力してください。')
    end
  end
  # rubocop:enable Style/CaseEquality, Metrics/AbcSize
end
