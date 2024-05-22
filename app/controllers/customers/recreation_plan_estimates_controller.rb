# frozen_string_literal: true

class Customers::RecreationPlanEstimatesController < Customers::ApplicationController
  before_action :require_customer

  def index
    RecreationPlanEstimate.where(user_id: current_user.id)
  end

  def show
    @recreation_plan_estimate = RecreationPlanEstimate.find_by!(id: params[:id], user_id: current_user.id)
    @recreation_recreation_plans = @recreation_plan_estimate.recreation_plan.recreation_recreation_plans
    @recreation_size = @recreation_recreation_plans.size
    @has_material_price_recreations = @recreation_recreation_plans.reject do |plan|
      @recreation_plan_estimate.material_price_for_plan(plan) == 0
    end
    @total_price = @recreation_recreation_plans.sum do |plan|
      plan.recreation.price +
        @recreation_plan_estimate.material_price_for_plan(plan) +
        @recreation_plan_estimate.transportation_expenses
    end
    @total_price_per_person = @total_price / @recreation_plan_estimate.number_of_people
    @actual_months = @recreation_recreation_plans.map do |plan|
      ((@recreation_plan_estimate.start_month + plan.month - 1) % 12).zero? ? 12 : (@recreation_plan_estimate.start_month + plan.month - 1) % 12 # rubocop:disable Layout/LineLength
    end
  end
end
