# frozen_string_literal: true

# == Schema Information
#
# Table name: recreation_plan_estimates
#
#  id                      :bigint           not null, primary key
#  estimate_number         :string           not null
#  number_of_people        :integer          not null
#  start_month             :integer          not null
#  transportation_expenses :integer          not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  recreation_plan_id      :bigint           not null
#  user_id                 :bigint           not null
#
# Indexes
#
#  index_recreation_plan_estimates_on_recreation_plan_id           (recreation_plan_id)
#  index_recreation_plan_estimates_on_user_id                      (user_id)
#  index_recreation_plan_estimates_on_user_id_and_estimate_number  (user_id,estimate_number) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (recreation_plan_id => recreation_plans.id)
#  fk_rails_...  (user_id => users.id)
#
class RecreationPlanEstimate < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :recreation_plan, class_name: 'RecreationPlan'

  validates :number_of_people, presence: true
  validates :start_month, presence: true
  validates :transportation_expenses, presence: true
  validates :user_id, uniqueness: { scope: :estimate_number }
  validate :start_month_is_valid

  before_create :generate_estimate_number

  delegate :recreation_recreation_plans, to: :recreation_plan

  def material_price_for_plan(plan)
    plan.recreation.material_price * number_of_people
  end

  def transportation_expenses_for_plan(recreation_recreation_plans)
    transportation_expenses * recreation_recreation_plans.size
  end

  def actual_months
    recreation_plan.recreation_recreation_plans.map do |plan|
      ((start_month + plan.month - 1) % 12).zero? ? 12 : ((start_month + plan.month - 1) % 12)
    end
  end

  def total_price
    recreation_recreation_plans.sum do |plan|
      plan.recreation.price + material_price_for_plan(plan) + transportation_expenses
    end
  end

  def total_price_per_person
    ((total_price * 1.1) / number_of_people).floor
  end

  def has_material_price_recreations
    recreation_recreation_plans.reject { |plan| material_price_for_plan(plan).zero? }
  end

  private def generate_estimate_number
    last_estimate = RecreationPlanEstimate.where(user_id:).order(estimate_number: :desc).first
    self.estimate_number = if last_estimate
                             increment_estimate_number(last_estimate.estimate_number)
                           else
                             'P000001'
                           end
  end

  private def increment_estimate_number(last_estimate_number)
    prefix = last_estimate_number[0]
    number = last_estimate_number[1..].to_i
    new_number = number + 1
    "#{prefix}#{new_number.to_s.rjust(6, '0')}"
  end

  private def start_month_is_valid
    return if start_month.between?(1, 12)

    errors.add(:start_month, 'は1から12の整数で入力してください')
  end
end
