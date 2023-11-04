# frozen_string_literal: true

# == Schema Information
#
# Table name: recreation_plans
#
#  id             :bigint           not null, primary key
#  code           :string           not null
#  release_status :integer          default(0), not null
#  title          :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_recreation_plans_on_code  (code) UNIQUE
#
class RecreationPlan < ApplicationRecord
  has_many :recreation_recretion_plans, dependent: :destroy
  has_many :recreations, through: :recreation_recretion_plans
end
