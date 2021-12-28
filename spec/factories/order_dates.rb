# == Schema Information
#
# Table name: order_dates
#
#  id           :bigint           not null, primary key
#  date         :integer
#  end_hour     :integer
#  end_minute   :integer
#  month        :integer
#  start_hour   :integer
#  start_minute :integer
#  year         :integer
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
FactoryBot.define do
  factory :order_date do
    order
    year { 2022 }
    month { 1 }
    date { 1 }
    start_hour { 13 }
    start_minute { 30 }
    end_hour { 14 }
    end_minute { 30 }
  end
end
