# frozen_string_literal: true

class Customers::UserRecreationPlansController < Customers::ApplicationController
  def index
    UserRecreationPlan.where(user: current_user)
  end
end
