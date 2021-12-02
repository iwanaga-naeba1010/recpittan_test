# frozen_string_literal: true

# == Schema Information
#
# Table name: order_memos
#
#  id         :bigint           not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :bigint           not null
#
# Indexes
#
#  index_order_memos_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...                (order_id => orders.id)
#  order_memos_order_id_fkey   (order_id => orders.id)
#  order_memos_order_id_fkey1  (order_id => orders.id)
#
require 'rails_helper'

RSpec.describe OrderMemo, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
