class Customers::OrdersController < Customers::ApplicationController
  before_action :set_recreation, only: %i[new create]

  def new
    @breadcrumbs = [
      { name: 'トップ' },
      { name: '一覧' },
      { name: '旅行' },
      { name: '～おはらい町おかげ横丁ツアー～' }
    ]
    @recreation = Recreation.find(params[:recreation_id])
    @order = @recreation.orders.build
    @years = [2021, 2022]
    @months = 1..12
    @dates = 1..31
    @hours = ['08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18']
    @minutes = ['00', '15', '30', '45']

  end

  def create
    @order = @recreation.orders.build(params_create)

    ActiveRecord::Base.transaction do
      @order.save
      dates = params_create.to_h[:dates]

      message = "
      リクエスト内容
      #{@order.order_type_text}
      希望日時
      1:#{parse_date(dates["0"])}
      2:#{parse_date(dates["1"])}
      3:#{parse_date(dates["2"])}

      希望人数
      #{@order.number_of_people}人

      介護度目安
      #{@order.tags.map {|tag| tag.name}.join("\n")}

      住所
      #{@order.prefecture}#{@order.city}

      相談したい事
      #{params_create[:message]}
      "

      Chat.create(
        order_id: @order.id,
        user_id: current_user.id,
        message: message,
        is_read: false,
      )
      # orderの詳細に飛ばす
      redirect_to chat_customers_order_path(@order.id)
    end
  rescue => e
    render :new
  end

  def show
    @breadcrumbs = [
      { name: 'トップ' },
      { name: '一覧' },
      { name: '旅行' },
      { name: '～おはらい町おかげ横丁ツアー～' }
    ]
    @order = current_user.orders.find(params[:id])
  end

  def chat
    @breadcrumbs = [
      { name: 'トップ' },
      { name: '一覧' },
      { name: '旅行' },
      { name: '～おはらい町おかげ横丁ツアー～' }
    ]
    @order = current_user.orders.find(params[:id])
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
