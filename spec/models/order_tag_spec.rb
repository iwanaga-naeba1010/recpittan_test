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
# Indexes
#
#  index_order_tags_on_order_id  (order_id)
#  index_order_tags_on_tag_id    (tag_id)
#
# Foreign Keys
#
#  fk_rails_...              (order_id => orders.id)
#  fk_rails_...              (tag_id => tags.id)
#  order_tags_order_id_fkey  (order_id => orders.id)
#  order_tags_tag_id_fkey    (tag_id => tags.id)
#
require 'rails_helper'

RSpec.describe OrderTag, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
