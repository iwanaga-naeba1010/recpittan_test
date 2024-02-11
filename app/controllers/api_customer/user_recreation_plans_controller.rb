# frozen_string_literal: true

module ApiCustomer
  class UserRecreationPlansController < ApplicationController
    def show
      user_recreation_plan = UserRecreationPlan.includes(
        user_recreation_recreation_plans: [
          recreation: %i[
            tags recreation_profile recreation_images recreation_prefectures profile
          ]
        ]
      ).find(params[:id])
      render json: UserRecreationPlanSerializer.new.serialize(user_recreation_plan:)
    end

    def create
      recreation_plan = RecreationPlan.find(params[:user_recreation_plan][:recreation_plan_id])
      user_recreation_plans_count = current_user.user_recreation_plans.count + 1

      user_recreation_plan = UserRecreationPlan.new(
        recreation_plan:,
        user: current_user,
        code: "#{recreation_plan.code}-#{current_user.id}-#{user_recreation_plans_count}"
      )
      recreation_plan.recreation_recreation_plans.each do |rec_rec_plan|
        user_recreation_plan.user_recreation_recreation_plans.build(
          recreation_id: rec_rec_plan.recreation_id,
          month: rec_rec_plan.month
        )
      end

      if user_recreation_plan.save
        render json: {
          user_recreation_plan: UserRecreationPlanSerializer.new.serialize(user_recreation_plan:),
          redirect_url: '/customers/user_recreation_plans'
        }, status: :created
      else
        render json: { errors: user_recreation_plan.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
end
