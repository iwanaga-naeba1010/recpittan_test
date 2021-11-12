# frozen_string_literal: true

ActiveAdmin.register Chat do
  permit_params(
    %i[user_id recreation_id prefecture city number_of_people order_type],
  )

  controller do
    def create
      chat = Chat.new(
        user_id: params[:chat][:user_id].to_i,
        order_id: params[:chat][:order_id].to_i,
        message: params[:chat][:message]
      )
      chat.save
      # TODO: 動的にid入れる
      redirect_to admin_order_path(params[:chat][:order_id].to_i)
    end
  end
end
