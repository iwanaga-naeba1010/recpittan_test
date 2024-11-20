# frozen_string_literal: true

# == Schema Information
#
# Table name: chats
#
#  id         :bigint           not null, primary key
#  file       :text
#  is_read    :boolean
#  message    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :bigint           not null
#  user_id    :bigint           not null
#
# Foreign Keys
#
#  chats_order_id_fkey  (order_id => orders.id)
#  chats_user_id_fkey   (user_id => users.id)
#
FactoryBot.define do
  factory :chat do
    user
    order
    message { 'MyText' }
    is_read { false }
  end
end
