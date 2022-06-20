# frozen_string_literal: true

class CustomersController < Customers::ApplicationController
  def index
    order_by = params[:order].presence || :start_at
    @orders = order_by == 'status' ? current_user.orders.order("#{order_by} asc") : current_user.orders.order("#{order_by} desc")
  end
end
