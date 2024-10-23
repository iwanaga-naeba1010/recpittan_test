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
# Indexes
#
#  index_zooms_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#
class Zoom < ApplicationRecord
  extend Enumerize
  belongs_to :order, class_name: 'Order'

  enumerize :created_by, in: { partner: 0, admin: 1 }, default: 0

  validates :price, :created_by, presence: true
end
