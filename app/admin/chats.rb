# frozen_string_literal: true

ActiveAdmin.register Chat do
  menu false # NOTE: サイドバーに表示しない設定
  actions :create
  permit_params(
    %i[user_id recreation_id prefecture city number_of_people order_type]
  )

  controller do
    def create
      order = Order.find(params[:chat][:order_id])
      # NOTE(okubo): chatは施設として送るので、特別な実装にしてます
      chat = order.chats.build(
        user_id: order.user.id,
        message: params[:chat][:message]
      )
      chat.save

      redirect_to admin_order_path(order.id)
    end
  end
end
