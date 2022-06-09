# frozen_string_literal: true

class CustomersController < Customers::ApplicationController
  def index
    order_by = :start_at
    order_by = params[:order] if params[:order].present?
    @orders = current_user.orders.order("#{order_by} asc")
  end
end
