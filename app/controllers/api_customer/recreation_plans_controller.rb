# frozen_string_literal: true

module ApiCustomer
  class RecreationPlansController < ApplicationController
    def show
      recreation_plan = RecreationPlan.find(params[:id])
      render json: serialize(recreation_plan:)
    end
  end
end
