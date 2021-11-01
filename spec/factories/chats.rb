# == Schema Information
#
# Table name: chats
#
#  id         :bigint           not null, primary key
#  is_read    :boolean
#  message    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_chats_on_order_id  (order_id)
#  index_chats_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :chat do
    order { nil }
    message { "MyText" }
    is_read { false }
    user { nil }
  end
end
