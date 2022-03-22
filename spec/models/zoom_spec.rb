# frozen_string_literal: true

# == Schema Information
#
# Table name: zooms
#
#  id         :bigint           not null, primary key
#  created_by :integer
#  price      :integer          default(0)
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :bigint           not null
#
# Foreign Keys
#
#  zooms_order_id_fkey  (order_id => orders.id)
#
require 'rails_helper'

RSpec.describe Zoom, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
