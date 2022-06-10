# frozen_string_literal: true

class CustomersController < Customers::ApplicationController
  def index
    order_by = params[:order].presence || :start_at
    @orders = current_user.orders.order("#{order_by} asc")
  end
end
