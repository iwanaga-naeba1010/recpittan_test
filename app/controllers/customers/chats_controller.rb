# frozen_string_literal: true

class Customers::ChatsController < Customers::ApplicationController
  before_action :set_order

  # rubocop:disable Naming/HeredocDelimiterNaming
  def create
    # NOTE: Orderで保存することで、保存時にstatusのチェック機能を発火させる。
    @order.chats.build(params_create)
    if @order.save
      message = <<-EOF
        施設名名： #{current_user.company.facility_name}
        管理画面案件URL： #{admin_order_url(@order.id)}
        内容:
        #{params_create[:message]}
      EOF
      SlackNotifier.new(channel: '#アクティブチャットスレッド').send('施設からチャットが届きました', message)
      # TODO: jobで送信したい
      PartnerChatMailer.notify(@order, current_user).deliver_now
      redirect_to chat_customers_order_path(@order.id)
    else
      redirect_to chat_customers_order_path(@order.id), alert: '送信に失敗しました'
    end
  end
  # rubocop:enable Naming/HeredocDelimiterNaming

  private

  def set_order
    @order = current_user.orders.find(params[:order_id])
  end

  def params_create
    params.require(:chat).permit(:message, :user_id)
  end
end
