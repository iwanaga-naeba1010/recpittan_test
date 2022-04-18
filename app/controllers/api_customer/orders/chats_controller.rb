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
    @order.chats.build(params_create.merge(user: current_user))
    @order.save!

    message = <<~MESSAGE
      施設名名： #{current_user.company.facility_name}
      管理画面案件URL： #{admin_order_url(@order.id)}
      内容:
      #{params_create[:message]}
    MESSAGE

    SlackNotifier.new(channel: '#アクティブチャットスレッド').send('施設からチャットが届きました', message)
    PartnerChatMailer.notify(@order, current_user).deliver_now # TODO: jobで送信したい
    render_json OrderSerializer.new.serialize(order: @order)
  rescue StandardError => e
    logger.error e.message
    render_json([e.message], status: 422)
  end

  private

  def set_order
    @order = current_user.orders.find(params[:order_id])
  end

  def params_create
    params.require(:chat).permit(:message)
  end
end
