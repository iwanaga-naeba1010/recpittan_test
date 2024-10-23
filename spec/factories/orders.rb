# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id                      :bigint           not null, primary key
#  additional_facility_fee :integer          default(0)
#  amount                  :integer          default(0)
#  building                :string
#  city                    :string
#  contract_number         :string
#  coupon_code             :string
#  end_at                  :datetime
#  expenses                :integer          default(0)
#  final_check_status      :integer
#  is_accepted             :boolean          default(FALSE)
#  is_open                 :boolean          default(TRUE), not null
#  material_amount         :integer          default(0)
#  material_price          :integer          default(0)
#  memo                    :string
#  number_of_facilities    :integer
#  number_of_people        :integer
#  prefecture              :string
#  price                   :integer          default(0)
#  start_at                :datetime
#  status                  :integer
#  street                  :string
#  support_price           :integer          default(0)
#  transportation_expenses :integer          default(0)
#  zip                     :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  recreation_id           :bigint           not null
#  user_id                 :bigint           not null
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
    user
    recreation
    price { 20000 }
    amount { 10000 }
    material_price { 1000 }
    material_amount { 500 }
    number_of_people { 1 }
    message { 'MyText' }
    status { 10 }
    transportation_expenses { 0 }
    expenses { 0 }
    is_accepted { false }
    additional_facility_fee { 1500 }
    number_of_facilities { 1 }
  end

  trait :with_report do
    after(:create) do |order|
      create(:report, order_id: order.id)
    end
  end

  trait :with_order_dates do
    after(:create) do |order|
      create(:order_date, order_id: order.id)
    end
  end

  trait :with_unreported_completed do
    after(:create) do |order|
      order.update(
        start_at: DateTime.yesterday,
        is_accepted: true
      )
    end
  end

  trait :with_final_report_admits_not do
    after(:create) do |order|
      create(:report, order_id: order.id)
      order.update(
        start_at: 3.days.ago,
        is_accepted: true
      )
    end
  end

  trait :with_finished do
    after(:create) do |order|
      report = create(:report, order_id: order.id, status: :accepted)
      create(:evaluation, report_id: report.id)

      order.update(
        start_at: 3.days.ago,
        is_accepted: true
      )
    end
  end
end
