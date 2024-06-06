# frozen_string_literal: true

class Customers::RecreationPlanEstimatesController < Customers::ApplicationController
  before_action :require_customer

  def index
    @recreation_plan_estimates = RecreationPlanEstimate.where(user_id: current_user.id)
  end

  def show
    @recreation_plan_estimate = RecreationPlanEstimate.find_by!(id: params[:id], user_id: current_user.id)
    @recreation_recreation_plans = @recreation_plan_estimate.recreation_recreation_plans
    @recreation_size = @recreation_recreation_plans.size
    @has_material_price_recreations = @recreation_plan_estimate.has_material_price_recreations
    @total_price = @recreation_plan_estimate.total_price
    @consumption_tax = @total_price * 0.1
    @total_price_per_person = @recreation_plan_estimate.total_price_per_person
    @actual_months = @recreation_plan_estimate.actual_months
  end
end
