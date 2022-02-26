# frozen_string_literal: true

# == Schema Information
#
# Table name: order_dates
#
#  id           :bigint           not null, primary key
#  date         :string
#  end_hour     :string
#  end_minute   :string
#  month        :string
#  start_hour   :string
#  start_minute :string
#  year         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  order_id     :bigint           not null
#
# Indexes
#
#  index_order_dates_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#
require 'rails_helper'

RSpec.describe OrderDate, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
