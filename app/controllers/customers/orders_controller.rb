# frozen_string_literal: true

class Customers::OrdersController < Customers::ApplicationController
  before_action :set_recreation, only: %i[new create]

  def show
    @breadcrumbs = [
      { name: 'トップ' },
      { name: '一覧' },
      { name: '旅行' },
      { name: '～おはらい町おかげ横丁ツアー～' }
    ]
    # @order = @recreation.orders.build
    @years = [2021, 2022]
    @months = 1..12
    @dates = 1..31
    @hours = ['08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18']
    @minutes = ['00', '15', '30', '45']
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

  def complete
    @order = current_user.orders.find(params[:id])
    return redirect_to chat_customers_order_path(@order.id) if @order.status.consult?

    @breadcrumbs = [
      { name: 'トップ' },
      { name: '一覧' },
      { name: '旅行' },
      { name: '～おはらい町おかげ横丁ツアー～' }
    ]

  end

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

      # TODO: 希望日時が空でも大丈夫なようにする
      message = "
      リクエスト内容
      #{@order.status_text}
      希望日時
      #{parse_date(dates)}

      希望人数
      #{@order.number_of_people}人

      介護度目安
      #{@order.tags.map {|tag| tag.name}.join('\n')}

      住所
      #{@order.prefecture}#{@order.city}

      相談したい事
      #{params_create[:message]}
      "

      Chat.create(
        order_id: @order.id,
        user_id: current_user.id,
        message: message,
        is_read: false
      )
      # orderの詳細に飛ばす
      redirect_to chat_customers_order_path(@order.id)
    end
  rescue => e
    binding.pry
    @breadcrumbs = [
      { name: 'トップ' },
      { name: '一覧' },
      { name: '旅行' },
      { name: '～おはらい町おかげ横丁ツアー～' }
    ]
    @years = [2021, 2022]
    @months = 1..12
    @dates = 1..31
    @hours = ['08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18']
    @minutes = ['00', '15', '30', '45']
    render :new
  end

  def update
    @order = current_user.orders.find(params[:id])
    if @order.update(status: :order)
      redirect_to complete_customers_order_path(@order.id), notice: '正式に依頼しました'
    else
      redirect_to chat_customers_order_path(@order.id), alert: '失敗しました。もう一度お試しください'
    end
  end

  private

  def set_recreation
    @recreation = Recreation.find(params[:recreation_id])
  end

  def parse_date(dates)
    return '' if dates.blank?

    str = ''
    accepted_attrs = ['0', '1', '2']
    accepted_attrs.each do |attr|
      # TODO: 入力が完了していない場合はvalidation error or チャット文章に含めない、という実装で
      param = dates[attr]
      str += "#{attr.to_i + 1}:#{param['year']}/#{param['month']}/#{param['date']} #{param['start_hour']}:#{param['start_minutes']}~#{param['end_hour']}:#{param['end_minutes']}\n"
    end

    str
  end

  def params_create
    params.require(:order).permit(
      :prefecture, :city, :status, :number_of_people, :user_id, :message,
      :is_online, :is_accepted, :date_and_time,
      { dates: {} },
      { tag_ids: [] }
    )
  end
end
