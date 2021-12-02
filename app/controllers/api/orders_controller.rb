# frozen_string_literal: true

class Api::OrdersController < Api::ApplicationController

  def update
    @order = current_user.orders.find(params[:id])
    @order.update(params_create)
    render_json({ order: @order })
  rescue StandardError => e
    logger.error e.message
    render_json({ message: e.message }, status: 422)
  end

  private

  def params_create
    params.require(:order).permit(:transportation_expenses, :expenses)
  end
end
