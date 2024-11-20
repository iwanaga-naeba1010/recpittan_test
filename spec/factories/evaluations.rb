# frozen_string_literal: true

# == Schema Information
#
# Table name: evaluations
#
#  id                  :bigint           not null, primary key
#  communication       :integer
#  ingenuity           :integer
#  is_public           :boolean          default("public")
#  message             :text
#  other_message       :text
#  price               :integer
#  smoothness          :integer
#  want_to_order_agein :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  report_id           :bigint           not null
#
# Foreign Keys
#
#  evaluations_report_id_fkey  (report_id => reports.id)
#
FactoryBot.define do
  factory :evaluation do
    report
    ingenuity { 1 }
    communication { 1 }
    smoothness { 1 }
    price { 1 }
    want_to_order_agein { 1 }
    message { 'MyText' }
    other_message { 'MyText' }
  end
end
