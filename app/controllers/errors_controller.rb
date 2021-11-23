# frozen_string_literal: true

class ErrorsController < ApplicationController
  skip_before_action :authenticate_user!

  def routing_error
    raise ActionController::RoutingError, "No route matches #{request.path.inspect}"
  end
end
