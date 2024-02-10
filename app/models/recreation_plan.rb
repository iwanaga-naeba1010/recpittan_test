# frozen_string_literal: true

# == Schema Information
#
# Table name: recreation_plans
#
#  id             :bigint           not null, primary key
#  code           :string           not null
#  release_status :integer          default("draft"), not null
#  title          :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_recreation_plans_on_code  (code) UNIQUE
#
class RecreationPlan < ApplicationRecord
  extend Enumerize

  has_many :recreation_recreation_plans, dependent: :destroy
  has_many :recreations, through: :recreation_recreation_plans
  has_many :user_recreation_plans, dependent: :destroy
  has_many :users, through: :user_recreation_plans
  has_many :recreation_plan_tags, dependent: :destroy
  has_many :tags, through: :recreation_plan_tags

  accepts_nested_attributes_for :recreation_recreation_plans, allow_destroy: true

  enumerize :release_status, in: { draft: 0, public: 1 }, default: 0

  validates :code, :release_status, :title, presence: true
  validates :code, uniqueness: true
  before_validation :generate_code, on: :create

  private def generate_code
    recreation_plan_count = RecreationPlan.count + 1
    sequence_num = recreation_plan_count.to_s.rjust(4, '0')
    self.code = "P#{sequence_num}"
  end
end
