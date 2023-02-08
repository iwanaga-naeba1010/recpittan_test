# frozen_string_literal: true

class CustomersController < Customers::ApplicationController
  def index
    column = params[:column].presence || :start_at
    order = params[:order].presence || :desc
    @is_open = params[:is_open].present? ? params[:is_open].to_s.downcase == 'true' : false
    @orders = current_user.orders.where(is_open: @is_open).order("#{column} #{order} NULLS LAST")
  end
end
