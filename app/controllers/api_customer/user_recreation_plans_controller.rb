# frozen_string_literal: true

module ApiCustomer
  class UserRecreationPlansController < ApplicationController
    def show
      user_recreation_plan = UserRecreationPlan.find(params[:id])
      render json: UserRecreationPlanSerializer.new.serialize(user_recreation_plan:)
    end

    def create; end
  end
end
