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
# Indexes
#
#  index_reports_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#
class Report < ApplicationRecord
  extend Enumerize
  belongs_to :order
  has_one :evaluation, dependent: :destroy
  accepts_nested_attributes_for :evaluation, allow_destroy: true

  delegate :regular_material_price, :number_of_people, :number_of_facilities, :transportation_expenses, :expenses, :support_price,
           :additional_facility_fee, :start_at, to: :order, prefix: true

  delegate :message, :other_message, to: :evaluation, prefix: true

  enumerize :status, in: { in_progress: 0, denied: 1, accepted: 2 }, default: 0
end
