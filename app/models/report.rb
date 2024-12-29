# frozen_string_literal: true

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
# Foreign Keys
#
#  reports_order_id_fkey  (order_id => orders.id)
#
class Report < ApplicationRecord
  include Ransackable
  extend Enumerize

  belongs_to :order, class_name: 'Order'
  has_one :evaluation, dependent: :destroy, class_name: 'Evaluation'
  accepts_nested_attributes_for :evaluation, allow_destroy: true

  delegate :number_of_people, :transportation_expenses, :expenses, to: :order, prefix: false, allow_nil: true
  delegate :ingenuity_text, :communication_text, :smoothness_text, :price_text,
           :want_to_order_agein_text, :message, :other_message, to: :evaluation, prefix: true, allow_nil: true

  enumerize :status, in: { in_progress: 0, denied: 1, accepted: 2 }, default: 0
end
