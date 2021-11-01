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
    # binding.pry
    @order = @recreation.orders.build(params_create)
    # TODO: ここでMessageを追加
    #  params_create.to_h でデータ取得できる


    ActiveRecord::Base.transaction do
      @order.save
      message = Chat.create(
        order_id: @order.id,
        user_id: current_user.id,
        message: "adadsdsada",
        is_read: false,
      )
      # orderの詳細に飛ばす
      redirect_to root_path
    end
  rescue => e
    render :new
  end

  private
  def set_recreation
    @recreation = Recreation.find(params[:recreation_id])
  end

  def params_create

    # dates = [
    #   { year: '', month: '', date: '', start_hour: '', start_minutes: '', end_hour: '', end_minutes: '' }
    # ]

    # TODO: 日程を追加できること
    params.require(:order).permit(
      :prefecture, :city, :order_type, :number_of_people, :user_id, { dates: {} },
      { tag_ids: [] }
    )
  end
end
