# == Schema Information
#
# Table name: reports
#
#  id                      :bigint           not null, primary key
#  body                    :text
#  expenses                :integer
#  facility_count          :integer
#  is_accepted             :boolean
#  number_of_people        :integer
#  transportation_expenses :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  order_id                :bigint           not null
#
# Indexes
#
#  index_reports_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#
FactoryBot.define do
  factory :report do
    order
    is_accepted { false }
    facility_count { 1 }
    number_of_people { 1 }
    transportation_expenses { 1 }
    expenses { 1 }
    body { 'MyText' }
  end
end
