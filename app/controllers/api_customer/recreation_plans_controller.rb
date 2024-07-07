# frozen_string_literal: true

module ApiCustomer
  class RecreationPlansController < ApplicationController
    skip_before_action :require_customer, only: [:show]
    before_action :require_customer_or_admin

    def show
      recreation_plan = RecreationPlan.includes(
        recreation_recreation_plans: [
          recreation: %i[
            tags recreation_profile recreation_images recreation_prefectures profile
          ]
        ]
      ).find(params[:id])
      render json: RecreationPlanSerializer.new.serialize(recreation_plan:)
    end

    private

    def require_customer_or_admin
      return if current_user.role.customer? || current_user.role.admin?

      render_json(['権限がありません'], status: 401)
    end
  end
end
