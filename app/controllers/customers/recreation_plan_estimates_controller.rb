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
    @total_price = @recreation_recreation_plans.sum do |plan|
      plan.recreation.price +
        @recreation_plan_estimate.material_price_for_plan(plan) +
        @recreation_plan_estimate.transportation_expenses
    end
  end
end
