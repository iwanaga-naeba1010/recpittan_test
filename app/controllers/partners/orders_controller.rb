# frozen_string_literal: true

class Partners::OrdersController < Partners::ApplicationController

  def show
    @order = current_user.recreations.map do |rec|
      rec.orders.map { |order| order if order.id == params[:id].to_i }
    end.flatten.compact.first
  end

  def chat
    @order = current_user.recreations.map do |rec|
      rec.orders.map { |order| order if order.id == params[:id].to_i }
    end.flatten.compact.first
    @chat = current_user.chats.build(order_id: @order.id)
  end

  def confirm; end
end
