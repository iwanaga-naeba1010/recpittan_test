# frozen_string_literal: true

class ApiCustomer::OrdersController < Api::ApplicationController
  before_action :set_order, only: %i[show update]

  def show
    render_json OrderSerializer.new.serialize(order: @order)
  rescue StandardError => e
    logger.error e.message
    render_json({ message: e.message }, status: 422)
  end

  def update
    @order.update(params_create)
    render_json OrderSerializer.new.serialize(order: @order)
  rescue StandardError => e
    logger.error e.message
    render_json([e.message], status: 422)
  end

  def preferred_date
    years = Year.all.map(&:value)
    months = Month.all.map(&:value)
    days = Day.all.map(&:value)
    hours = Hour.all.map(&:value)
    minutes = Minute.all.map(&:value)
    render_json OrderConfigSerializer.new.serialize(
      years: years, months: months, days: days, hours: hours, minutes: minutes
    )
  end

  private

  def set_order
    @order = current_user.orders.find(params[:id])
  end

  def params_create
    params.require(:order).permit(
      :transportation_expenses, :expenses, :number_of_facilities,
      :zip, :prefecture, :city, :street, :building, :status,
      :number_of_people, :number_of_facilities,
      :start_at, :end_at
    )
  end
end
