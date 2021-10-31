class OrdersController < ApplicationController
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
end
