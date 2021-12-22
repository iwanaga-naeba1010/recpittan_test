# frozen_string_literal: true

class Customers::ChatsController < Customers::ApplicationController
  before_action :set_order

  def create
    # NOTE: Orderで保存することで、保存時にstatusのチェック機能を発火させる。
    @order.chats.build(params_create)
    if @order.save
      # TODO: jobで送信したい
      PartnerChatMailer.notify(@order, current_user).deliver_now
      redirect_to chat_customers_order_path(@order.id)
    else
      redirect_to chat_customers_order_path(@order.id), alert: '送信に失敗しました'
    end
  end

  private

  def set_order
    @order = current_user.orders.find(params[:order_id])
  end

  def params_create
    params.require(:chat).permit(:message, :user_id)
  end
end
