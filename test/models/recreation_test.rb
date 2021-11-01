# == Schema Information
#
# Table name: recreations
#
#  id                  :bigint           not null, primary key
#  borrow_item         :text
#  bring_your_own_item :text
#  description         :text
#  extra_information   :text
#  flow_of_day         :text
#  minutes             :integer
#  price               :integer          default(0), not null
#  second_title        :string
#  title               :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :bigint           not null
#  youtube_id          :string
#
# Indexes
#
#  index_recreations_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'test_helper'

class RecreationTest < ActiveSupport::TestCase
  # test 'the truth' do
  #   assert true
  # end
end
