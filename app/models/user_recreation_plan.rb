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
class UserRecreationPlan < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :recreation_plan, class_name: 'RecreationPlan'
  has_many :user_recreation_recreation_plans, dependent: :destroy, class_name: 'UserRecreationRecreationPlan'
  has_many :recreations, through: :user_recreation_recreation_plans, class_name: 'Recreation'

  delegate :title, to: :recreation_plan, prefix: true
end
