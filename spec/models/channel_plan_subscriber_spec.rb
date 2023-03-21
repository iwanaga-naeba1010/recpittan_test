# frozen_string_literal: true

# == Schema Information
#
# Table name: channel_plan_subscribers
#
#  id         :bigint           not null, primary key
#  kind       :integer
#  status     :integer          default("active")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint           not null
#
# Indexes
#
#  index_channel_plan_subscribers_on_company_id  (company_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
require 'rails_helper'

RSpec.describe ChannelPlanSubscriber, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
