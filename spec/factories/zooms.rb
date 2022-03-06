# frozen_string_literal: true

# == Schema Information
#
# Table name: zooms
#
#  id         :bigint           not null, primary key
#  created_by :integer
#  price      :integer          default(0)
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :bigint           not null
#
# Indexes
#
#  index_zooms_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#
FactoryBot.define do
  factory :zoom do
    order
    price { 300 }
    created_by { :partner }
    url { 'MyString' }
  end
end
