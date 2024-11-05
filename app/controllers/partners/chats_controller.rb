# frozen_string_literal: true

class Partners::ChatsController < Partners::ApplicationController
  before_action :set_order

  def create
    @chat = @order.chats.build(params_create)
    # NOTE: Order経由で保存することでbefore_saveを発火させている
    if @order.save
      message = <<~MESSAGE
        パートナー名： #{@order.recreation.profile_name}
        管理画面案件URL： #{admin_order_url(@order.id)}
        施設名: #{@order.user.company.facility_name}
        内容:
        #{params_create[:message]}
      MESSAGE
      SlackNotifier.new(channel: '#アクティブチャットスレッド').send('パートナーからチャットが届きました', message)
      CustomerChatMailer.notify(order: @order).deliver_now
      redirect_to chat_partners_order_path(@order.id)
    else
      render 'partners/orders/chat'
    end
  end

  private def set_order
    @order = current_user.recreations.map do |rec|
      rec.orders.map { |order| order if order.id == params[:order_id].to_i }
    end.flatten.compact.first
  end

  private def params_create
    params.require(:chat).permit(:message, :file, :user_id)
  end
end
