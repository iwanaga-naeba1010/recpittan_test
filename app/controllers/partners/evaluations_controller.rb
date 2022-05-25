# frozen_string_literal: true

class Partners::EvaluationsController < Partners::ApplicationController
  before_action :set_order

  def show; end

  private def set_order
    @order = current_user.recreations.map do |rec|
      rec.orders.map { |order| order if order.id == params[:order_id].to_i }
    end.flatten.compact.first
  end
end
