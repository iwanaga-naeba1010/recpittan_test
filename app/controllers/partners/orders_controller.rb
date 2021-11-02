class Partners::OrdersController < Partners::ApplicationController
  before_action :set_recreation, only: %i[new create]

  def show
    @breadcrumbs = [
      { name: 'トップ' },
      { name: '一覧' },
      { name: '旅行' },
      { name: '～おはらい町おかげ横丁ツアー～' }
    ]

    @order = current_user.recreations.map do |rec|
      rec.orders.map { |order| order if order.id == params[:id].to_i }
    end.flatten.compact.first
  end

  def chat
    @breadcrumbs = [
      { name: 'トップ' },
      { name: '一覧' },
      { name: '旅行' },
      { name: '～おはらい町おかげ横丁ツアー～' }
    ]
    @order = current_user.recreations.map do |rec|
      rec.orders.map { |order| order if order.id == params[:id].to_i }
    end.flatten.compact.first
    @chat = current_user.chats.build(order_id: @order.id)
  end

  private

  def set_recreation
    @recreation = Recreation.find(params[:recreation_id])
  end

  def parse_date(date)
    "#{date["year"]}/#{date["month"]}/#{date["date"]} #{date["start_hour"]}:#{date["start_minutes"]}~#{date["end_hour"]}:#{date["end_minutes"]}"
  end

  def params_create
    params.require(:order).permit(
      :prefecture, :city, :order_type, :number_of_people, :user_id, :message, { dates: {} },
      { tag_ids: [] }
    )
  end
end
