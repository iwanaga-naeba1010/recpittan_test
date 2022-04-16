# frozen_string_literal: true

class ApiCustomer::Orders::ChatsController < Api::ApplicationController
  before_action :set_order, only: %i[index create]

  def index
    render_json ChatSerializer.new.serialize_list(chats: @order.chats)
  rescue StandardError => e
    logger.error e.message
    render_json({ message: e.message }, status: 422)
  end

  def create
    chat = current_user.chats.build(params_create)
    chat.order_id = params[:order_id]
    chat.save!
    render_json OrderSerializer.new.serialize(order: @order)
  rescue StandardError => e
    logger.error e.message
    render_json({ message: e.message }, status: 422)
  end

  private

  def set_order
    @order = current_user.orders.find(params[:order_id])
  end

  def params_create
    params.require(:chat).permit(:message)
  end
end
