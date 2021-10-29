# == Schema Information
#
# Table name: recreation_targets
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  recreation_id :bigint           not null
#  target_id     :bigint           not null
#
# Indexes
#
#  index_recreation_targets_on_recreation_id  (recreation_id)
#  index_recreation_targets_on_target_id      (target_id)
#
# Foreign Keys
#
#  fk_rails_...  (recreation_id => recreations.id)
#  fk_rails_...  (target_id => targets.id)
#
require "test_helper"

class RecreationTargetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
