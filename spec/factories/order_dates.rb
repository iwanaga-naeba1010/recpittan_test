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
FactoryBot.define do
  factory :order_date do
    order
    year { '2030' }
    month { '12' }
    date { '31' }
    start_hour { '13' }
    start_minute { '00' }
    end_hour { '14' }
    end_minute { '30' }
  end
end
