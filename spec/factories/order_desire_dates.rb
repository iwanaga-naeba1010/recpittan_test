# frozen_string_literal: true

# == Schema Information
#
# Table name: order_desire_dates
#
#  id          :bigint           not null, primary key
#  desire_date :date
#  desire_no   :integer
#  time_from   :time
#  time_to     :time
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  order_id    :bigint           not null
#
# Indexes
#
#  index_order_desire_dates_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#
FactoryBot.define do
  factory :order_desire_date do
    order
    desire_no { 1 }
    desire_date { '2025-02-26' }
    time_from { '2025-02-26 22:20:27' }
    time_to { '2025-02-26 22:20:27' }
  end
end
