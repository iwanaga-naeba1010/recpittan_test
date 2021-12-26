# frozen_string_literal: true

class Customers::OrdersController < Customers::ApplicationController
  before_action :set_recreation, only: %i[new create]
  before_action :set_order, only: %i[show chat update complete]

  def new
    @recreation = Recreation.find(params[:recreation_id])
    @order = @recreation.orders.build
    @order.order_dates.build
  end

  def show; end

  def chat
    @chat = current_user.chats.build(order_id: @order.id)
  end

  def complete
    redirect_to chat_customers_order_path(@order.id) if @order.start_at.blank?
  end

  # rubocop:disable Metrics/AbcSize
  def create
    @order = @recreation.orders.build(params_create)
    # date_value = params_create.to_h[:dates].to_a[0].to_a[1].values
    # date = []
    # date_value.each do |v|
    #   date << v if v === "ー"
    # end

    # unless date.length === 0 || date.length === 7
    #   render new
    # end

    ActiveRecord::Base.transaction do
      @order.save!
      # dates = params_create.to_h[:dates]

      # TODO: 希望日時が空でも大丈夫なようにする
      # TODO: EOS入力にすればタブが入ってしまったようなmessageは解消が可能
      message = <<EOS
        リクエスト内容
        #{@order.title}
        希望人数
        #{@order.number_of_people}人

        介護度目安
        #{params_create[:tags]&.join('\n')}

        住所
        #{@order.prefecture}#{@order.city}

        相談したい事
        #{params_create[:message]}
EOS

      Chat.create(
        order_id: @order.id,
        user_id: current_user.id,
        message: message,
        is_read: false
      )
      slack_message = <<EOS
会社名: #{current_user.company.name}
管理画面URL: #{admin_company_url(current_user.company.id)}
担当者名: #{current_user.company.person_in_charge_name}
電話番号: #{current_user.company.tel}

レク名: #{@recreation.title}
パートナー名: #{@recreation.instructor_name}
------------------
#{message}
EOS
      SlackNotifier.new(channel: '#料金お問い合わせ').send('新規お問い合わせ', slack_message)
      # TODO: jobで回した方が良い
      # CustomerChatStartMailer.notify(@order, current_user).deliver_now
      # PartnerChatStartMailer.notify(@order, current_user).deliver_now
      # orderの詳細に飛ばす
      redirect_to chat_customers_order_path(@order.id)
    end
  # rubocop:disable Lint/UselessAssignment
  rescue StandardError
    render :new
  end
  # rubocop:enable Lint/UselessAssignment

  def update
    ActiveRecord::Base.transaction do
      date = params_create.to_h[:dates]['0']
      start_at = Time.new(date['year'].to_i, date['month'].to_i, date['date'].to_i, date['start_hour'].to_i, date['start_minutes'].to_i)

      end_at = Time.new(date['year'].to_i, date['month'].to_i, date['date'].to_i, date['end_hour'].to_i, date['end_minutes'].to_i)
      # TODO: 若干負債だけど、今は許容する
      @order.update(start_at: start_at, end_at: end_at)

      @order.update(params_create)

      # TODO: jobで送信したい
      OrderRequestMailer.notify(@order, current_user).deliver_now
      redirect_to complete_customers_order_path(@order.id), notice: '正式に依頼しました'
    end
  rescue StandardError
    redirect_to chat_customers_order_path(@order.id), alert: '失敗しました。もう一度お試しください'
  end
  # rubocop:enable Metrics/AbcSize

  private

  def set_recreation
    @recreation = Recreation.find(params[:recreation_id])
  end

  def set_order
    @order = current_user.orders.find(params[:id])
  end

  def parse_date(dates)
    return '' if dates.blank?

    str = ''
    accepted_attrs = ['0', '1', '2']
    accepted_attrs.each do |attr|
      # TODO: 入力が完了していない場合はvalidation error or チャット文章に含めない、という実装で
      param = dates[attr]
      # rubocop:disable Layout/LineLength
      str += "#{attr.to_i + 1}:#{param['year']}/#{param['month']}/#{param['date']} #{param['start_hour']}:#{param['start_minutes']}~#{param['end_hour']}:#{param['end_minutes']}\n"
      # rubocop:enable Layout/LineLength
    end

    str
  end

  def params_create
    params.require(:order).permit(
      :title, :zip, :prefecture, :city, :street, :building, :status,
      :number_of_people, :number_of_facilities,
      :user_id, :message,
      :is_online, :is_accepted,
      # TODO: ここに追加したカラムを挿入する
      :regular_price,
      :instructor_amount,
      :regular_material_price,
      :instructor_material_amount,
      :additional_facility_fee,
      :start_at,
      # { dates: {} },
      { tags: [] },
      order_dates_attributes:[
        :id, :year, :month, :date, :start_hour, :start_minute, :end_hour, :end_minute,
      ]
    )
  end
end
