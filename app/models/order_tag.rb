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
class OrderTag < ApplicationRecord
  belongs_to :order, class_name: 'Order'
  belongs_to :tag, class_name: 'Tag'
end
