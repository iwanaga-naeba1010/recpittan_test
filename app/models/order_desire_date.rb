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
class OrderDesireDate < ApplicationRecord
  belongs_to :order, class_name: 'Order'

  validates :desire_no, inclusion: { in: 1..3 }
end
