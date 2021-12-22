# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id                         :bigint           not null, primary key
#  additional_facility_fee    :integer          default(0)
#  building                   :string
#  city                       :string
#  end_at                     :datetime
#  expenses                   :integer          default(0)
#  instructor_amount          :integer          default(0)
#  instructor_material_amount :integer          default(0)
#  is_accepted                :boolean          default(FALSE)
#  number_of_facilities       :integer
#  number_of_people           :integer
#  prefecture                 :string
#  regular_material_price     :integer          default(0)
#  regular_price              :integer          default(0)
#  start_at                   :datetime
#  status                     :integer
#  street                     :string
#  support_price              :integer          default(0)
#  transportation_expenses    :integer          default(0)
#  zip                        :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  recreation_id              :bigint           not null
#  user_id                    :bigint           not null
#
# Foreign Keys
#
#  orders_recreation_id_fkey  (recreation_id => recreations.id)
#  orders_user_id_fkey        (user_id => users.id)
#
FactoryBot.define do
  factory :order do
    user
    recreation
    number_of_people { 1 }
    message { 'MyText' }
    status { 10 }
    transportation_expenses { 0 }
    expenses { 0 }
    is_accepted { false }
  end

  trait :with_report do
    after(:create) do |order|
      create(:report, order_id: order.id)
    end
  end
end
