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
FactoryBot.define do
  factory :recreation_plan do
    title { 'MyString' }
    release_status { 1 }
  end
end
