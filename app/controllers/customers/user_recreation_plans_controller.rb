# frozen_string_literal: true

class Customers::UserRecreationPlansController < Customers::ApplicationController
  def index
    user_recreation_plans = UserRecreationPlan.where(user: current_user)
  end
end
