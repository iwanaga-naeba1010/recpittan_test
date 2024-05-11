# frozen_string_literal: true

class Customers::RecreationPlanEstimatesController < Customers::ApplicationController
  before_action :require_customer

  def index
    RecreationPlanEstimate.where(user_id: current_user.id)
  end

  def show
    id = params[:id]
    RecreationPlanEstimate.find_by!(id: id, user_id: current_user.id)
  end
end
