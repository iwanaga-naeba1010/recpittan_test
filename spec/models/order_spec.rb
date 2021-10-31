# == Schema Information
#
# Table name: orders
#
#  id               :bigint           not null, primary key
#  city             :string
#  number_of_people :integer
#  order_type       :integer
#  prefecture       :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  recreation_id    :bigint           not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_orders_on_recreation_id  (recreation_id)
#  index_orders_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (recreation_id => recreations.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Order, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
