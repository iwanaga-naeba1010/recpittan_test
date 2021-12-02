# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id                      :bigint           not null, primary key
#  city                    :string
#  date_and_time           :datetime
#  expenses                :integer
#  is_accepted             :boolean          default(FALSE)
#  number_of_people        :integer
#  prefecture              :string
#  status                  :integer
#  transportation_expenses :integer
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
    number_of_people { 1 }
    message { 'MyText' }
    status { 0 }
    transportation_expenses { 0 }
    expenses { 0 }
    is_accepted { false }
  end
end
