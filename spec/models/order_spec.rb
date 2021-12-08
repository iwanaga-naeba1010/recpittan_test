# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id               :bigint           not null, primary key
#  city             :string
#  date_and_time    :datetime
#  is_accepted      :boolean          default(FALSE)
#  is_online        :boolean          default(FALSE)
#  number_of_people :integer
#  prefecture       :string
#  status           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  recreation_id    :bigint           not null
#  user_id          :bigint           not null
#
# Foreign Keys
#
#  orders_recreation_id_fkey  (recreation_id => recreations.id)
#  orders_user_id_fkey        (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Order, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
