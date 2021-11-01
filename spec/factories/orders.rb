# == Schema Information
#
# Table name: orders
#
#  id               :bigint           not null, primary key
#  city             :string
#  number_of_people :integer
#  order_type       :integer
#  prefecture       :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  recreation_id    :bigint           not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_orders_on_recreation_id  (recreation_id)
#  index_orders_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (recreation_id => recreations.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :order do
    user { nil }
    recreation { nil }
    number_of_people { 1 }
    message { 'MyText' }
    kind { 1 }
  end
end
