# frozen_string_literal: true

# == Schema Information
#
# Table name: recreation_plan_tags
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  recreation_id :bigint           not null
#  tag_id        :bigint           not null
#
# Indexes
#
#  index_recreation_plan_tags_on_recreation_id  (recreation_id)
#  index_recreation_plan_tags_on_tag_id         (tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (recreation_id => recreations.id)
#  fk_rails_...  (tag_id => tags.id)
#
require 'rails_helper'

RSpec.describe RecreationPlanTag, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
