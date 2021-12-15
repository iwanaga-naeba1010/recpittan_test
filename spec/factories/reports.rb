# == Schema Information
#
# Table name: reports
#
#  id                      :bigint           not null, primary key
#  body                    :text
#  expenses                :integer
#  number_of_facilities    :integer
#  number_of_people        :integer
#  status                  :integer
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
    status { :in_progress }
    number_of_facilities { 1 }
    number_of_people { 1 }
    transportation_expenses { 1 }
    expenses { 1 }
    body { 'MyText' }
  end
end
