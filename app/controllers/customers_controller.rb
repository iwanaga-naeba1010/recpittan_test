# frozen_string_literal: true

class CustomersController < Customers::ApplicationController
  def index
    column = params[:column].presence || :start_at
    order = params[:order].presence || :desc
    @orders = current_user.orders

    if params[:is_open].present?
      @is_open = params[:is_open].to_s.downcase == 'true'
      @orders = @orders.where(is_open: @is_open)
    end

    @orders = @orders.order("#{column} #{order} NULLS LAST")
  end
end
