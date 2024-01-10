# frozen_string_literal: true

# == Schema Information
#
# Table name: user_recreation_plans
#
#  id                 :bigint           not null, primary key
#  code               :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  recreation_plan_id :bigint           not null
#  user_id            :bigint           not null
#
# Indexes
#
#  index_user_recreation_plans_on_code                (code) UNIQUE
#  index_user_recreation_plans_on_recreation_plan_id  (recreation_plan_id)
#  index_user_recreation_plans_on_user_id             (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (recreation_plan_id => recreation_plans.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe UserRecreationPlan, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
