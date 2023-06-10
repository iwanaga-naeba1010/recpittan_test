# frozen_string_literal: true

class Partners::EvaluationsController < Partners::ApplicationController
  before_action :set_order, only: %i[show]

  def index
    @recreation = current_user.recreations.find(params[:recreation_id])
  end

  def show; end

  private def set_order
    @order = current_user.recreations.map do |rec|
      rec.orders.map { |order| order if order.id == params[:order_id].to_i }
    end.flatten.compact.first
  end
end
