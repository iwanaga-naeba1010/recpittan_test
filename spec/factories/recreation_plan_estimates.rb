# frozen_string_literal: true

# == Schema Information
#
# Table name: recreation_plan_estimates
#
#  id                      :bigint           not null, primary key
#  estimate_number         :string           not null
#  number_of_people        :integer          not null
#  start_month             :integer          not null
#  transportation_expenses :integer          not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  recreation_plan_id      :bigint           not null
#  user_id                 :bigint           not null
#
# Indexes
#
#  index_recreation_plan_estimates_on_recreation_plan_id           (recreation_plan_id)
#  index_recreation_plan_estimates_on_user_id                      (user_id)
#  index_recreation_plan_estimates_on_user_id_and_estimate_number  (user_id,estimate_number) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (recreation_plan_id => recreation_plans.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :recreation_plan_estimate do
    user { nil }
    transportation_expenses { 1 }
    start_month { 1 }
    number_of_people { 1 }
    recreation_plan { nil }
    estimate_number { 'MyString' }
  end
end
