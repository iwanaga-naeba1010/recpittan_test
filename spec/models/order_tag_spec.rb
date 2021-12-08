# frozen_string_literal: true

# == Schema Information
#
# Table name: order_tags
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :bigint           not null
#  tag_id     :bigint           not null
#
# Foreign Keys
#
#  order_tags_order_id_fkey  (order_id => orders.id)
#  order_tags_tag_id_fkey    (tag_id => tags.id)
#
require 'rails_helper'

RSpec.describe OrderTag, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
