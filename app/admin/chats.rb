# frozen_string_literal: true

ActiveAdmin.register Chat do
  menu false # NOTE: サイドバーに表示しない設定
  actions :create
  belongs_to :order

  permit_params { Chat.attribute_names.map(&:to_sym) }

  controller do
    def create
      order = Order.find(params[:order_id])
      # NOTE(okubo): chatは施設として送るので、特別な実装にしてます
      chat = order.chats.build(
        user_id: order.user.id,
        message: params[:chat][:message]
      )
      chat.save

      PartnerChatMailer.notify(order: order).deliver_now
      SlackNotifier.new(channel: '#アクティブチャットスレッド').send('管理画面からチャット送信を行いました', "管理画面案件URL：#{admin_order_url(order.id)}")
      redirect_to admin_order_path(order.id)
    end
  end
end
