# frozen_string_literal: true

module ApiCustomer
  class RecreationPlanEstimatesController < ApplicationController
    def create
      recreation_plan_estimate = Resources::RecreationPlanEstimates::Create.run!(
        number_of_people: params_create[:number_of_people].to_i,
        start_month: params_create[:start_month].to_i,
        transportation_expenses: params_create[:transportation_expenses].to_i,
        recreation_plan_id: params_create[:recreation_plan_id].to_i,
        user_id: current_user.id
      )
      render_json RecreationPlanEstimateSerializer.new.serialize(recreation_plan_estimate:)
    rescue StandardError => e
      render_json([e.message], status: 422)
    end

    private def params_create
      params.require(:recreation_plan_estimate).permit(
        :number_of_people, :start_month, :transportation_expenses, :recreation_plan_id
      )
    end
  end
end
