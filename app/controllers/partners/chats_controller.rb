class Partners::ChatsController < Partners::ApplicationController

  def create
    @chat = current_user.chats.build(params_create)

    if @chat.save
      redirect_to chat_partners_order_path(@chat.order_id)
    else
      @order = current_user.recreations.map do |rec|
        rec.orders.map { |order| order if order.id == params[:id].to_i }
      end.flatten.compact.first
      @chat = @order.chats.build(user_id: current_user.id)
      render 'partners/orders/chat'
    end
  end

  private

  def params_create
    params.require(:chat).permit(:message, :order_id)
  end
end
