# frozen_string_literal: true

# == Schema Information
#
# Table name: recreation_plans
#
#  id             :bigint           not null, primary key
#  adjustment_fee :integer
#  code           :string           not null
#  disporder      :integer          default(0)
#  release_status :integer          default("draft"), not null
#  title          :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  company_id     :bigint
#
# Indexes
#
#  index_recreation_plans_on_code        (code) UNIQUE
#  index_recreation_plans_on_company_id  (company_id)
#
require 'rails_helper'

RSpec.describe RecreationPlan, type: :model do
  it { is_expected.to have_db_column(:disporder).of_type(:integer).with_options(default: 0) }
end
