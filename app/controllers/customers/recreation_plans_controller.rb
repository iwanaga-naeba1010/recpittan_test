# frozen_string_literal: true

class Customers::RecreationPlansController < Customers::ApplicationController
  before_action :require_customer

  def index
    @recreation_plans = RecreationPlan.includes(:recreations)
                                      .where(release_status: :public)
                                      .page(params[:page]).per(10)
    @recreation_plans_with_total_price = @recreation_plans.map do |plan|
      total_price = plan.recreations.sum(:price)
      [plan, total_price]
    end
  end

  def show
    @recreation_plan = RecreationPlan.find(params[:id])
    unless @recreation_plan.visible_to_user?(current_user)
      redirect_to customers_recreation_plans_path, alert: t('action_messages.unauthorized')
    end
  end
end
