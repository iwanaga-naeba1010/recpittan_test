# frozen_string_literal: true

# == Schema Information
#
# Table name: order_memos
#
#  id         :bigint           not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :bigint           not null
#
# Indexes
#
#  index_order_memos_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#
class OrderMemo < ApplicationRecord
  belongs_to :order, class_name: 'Order'
end
