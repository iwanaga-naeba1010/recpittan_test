# frozen_string_literal: true

ActiveAdmin.register OrderMemo do
  menu false # NOTE: サイドバーに表示しない設定
  actions :create
  belongs_to :order
  permit_params(
    %i[order_id body]
  )

  controller do
    def create
      memo = OrderMemo.new(
        order_id: params[:order_memo][:order_id].to_i,
        body: params[:order_memo][:body]
      )
      memo.save
      # TODO: 動的にid入れる
      redirect_to admin_order_path(params[:order_memo][:order_id].to_i)
    end
  end
end
