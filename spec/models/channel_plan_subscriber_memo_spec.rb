# frozen_string_literal: true

# == Schema Information
#
# Table name: channel_plan_subscriber_memos
#
#  id                         :bigint           not null, primary key
#  body                       :text
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  channel_plan_subscriber_id :bigint           not null
#
# Indexes
#
#  index_subscriber_memos_on__subscriber_id  (channel_plan_subscriber_id)
#
# Foreign Keys
#
#  fk_rails_...  (channel_plan_subscriber_id => channel_plan_subscribers.id)
#
require 'rails_helper'

RSpec.describe ChannelPlanSubscriberMemo, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
