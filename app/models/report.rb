# == Schema Information
#
# Table name: reports
#
#  id                          :bigint           not null, primary key
#  additional_number_of_people :integer
#  body                        :text
#  expenses                    :integer
#  facility_count              :integer
#  is_accepted                 :boolean
#  number_of_people            :integer
#  transportation_expenses     :integer
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  order_id                    :bigint           not null
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
  belongs_to :order
end
