# frozen_string_literal: true

module ApiCustomer
  class RecreationPlansController < ApplicationController
    def show
      recreation_plan = RecreationPlan.includes(
        recreation_recreation_plans: [
          recreation: [
            :tags, :recreation_profile, :recreation_images, :recreation_prefectures, :profile
          ]
        ]
      ).find(params[:id])
      render json: RecreationPlanSerializer.new.serialize(recreation_plan:)
    end
  end
end
