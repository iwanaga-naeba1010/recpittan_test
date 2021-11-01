class OrdersController < ApplicationController
  before_action :set_recreation, only: %i[new create]

  def new
    @breadcrumbs = [
      { name: 'トップ' },
      { name: '一覧' },
      { name: '旅行' },
      { name: '～おはらい町おかげ横丁ツアー～' },
    ]
    @recreation = Recreation.find(params[:recreation_id])
    @order = @recreation.orders.build
  end

  def create
    @order = @recreation.orders.build(params_create)
    if @order.save
      # ここをchat画面にする
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def set_recreation
    @recreation = Recreation.find(params[:recreation_id])
  end

  def params_create
    # TODO: 日程を追加できること
    params.require(:order).permit(
      :prefecture, :city, :order_type, :number_of_people, :user_id,
      { tag_ids: [] }
    )
  end
end
