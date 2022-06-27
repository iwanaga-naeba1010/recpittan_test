# frozen_string_literal: true

class CustomersController < Customers::ApplicationController
  def index
    column = params[:column].presence || :start_at
    @orders = current_user.orders.order("#{column} asc NULLS LAST")
  end
end
