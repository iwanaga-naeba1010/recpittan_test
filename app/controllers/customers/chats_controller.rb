# frozen_string_literal: true

class Customers::ChatsController < Customers::ApplicationController

  def create
    @chat = current_user.chats.build(params_create)

    if @chat.save
      redirect_to chat_customers_order_path(@chat.order_id)
    else
      @breadcrumbs = [
        { name: 'トップ' },
        { name: '一覧' },
        { name: '旅行' },
        { name: '～おはらい町おかげ横丁ツアー～' }
      ]
      @order = current_user.orders.find(@chat.order_id)
      render 'orders/chat'
    end
  end

  private

  def params_create
    params.require(:chat).permit(:message, :order_id)
  end
end
