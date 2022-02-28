# frozen_string_literal: true

# == Schema Information
#
# Table name: evaluations
#
#  id                  :bigint           not null, primary key
#  communication       :integer
#  ingenuity           :integer
#  message             :text
#  other_message       :text
#  price               :integer
#  smoothness          :integer
#  want_to_order_agein :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  report_id           :bigint           not null
#
# Indexes
#
#  index_evaluations_on_report_id  (report_id)
#
# Foreign Keys
#
#  fk_rails_...  (report_id => reports.id)
#
require 'rails_helper'

RSpec.describe Evaluation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
