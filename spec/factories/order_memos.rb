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
# Foreign Keys
#
#  order_memos_order_id_fkey  (order_id => orders.id)
#
FactoryBot.define do
  factory :order_memo do
    order
    body { 'MyText' }
  end
end
