# frozen_string_literal: true

# == Schema Information
#
# Table name: recreation_plans
#
#  id                :bigint           not null, primary key
#  adjustment_fee    :integer
#  code              :string           not null
#  release_status    :integer          default("draft"), not null
#  title             :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  available_user_id :bigint
#
# Indexes
#
#  index_recreation_plans_on_available_user_id  (available_user_id)
#  index_recreation_plans_on_code               (code) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (available_user_id => users.id)
#
require 'rails_helper'

RSpec.describe RecreationPlan, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
