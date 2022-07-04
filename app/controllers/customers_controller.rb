# frozen_string_literal: true

class CustomersController < Customers::ApplicationController
  def index
    column = params[:column].presence || :start_at
    order = params[:order].presence || :desc
    @orders = current_user.orders.order("#{column} #{order} NULLS LAST")
  end
end
