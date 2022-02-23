# frozen_string_literal: true

class Customers::OrdersController < Customers::ApplicationController
  before_action :set_recreation, only: %i[new create]
  before_action :set_order, only: %i[show chat update complete]

  def new
    @recreation = Recreation.find(params[:recreation_id])
    @order = @recreation.orders.build
    3.times { @order.order_dates.build }
  end

  def show; end

  def chat
    @chat = current_user.chats.build(order_id: @order.id)
  end

  def complete
    redirect_to chat_customers_order_path(@order.id) if @order.start_at.blank?
  end

  # rubocop:disable Metrics/AbcSize, Naming/HeredocDelimiterNaming
  def create
    @order = @recreation.orders.build(params_create)

    ActiveRecord::Base.transaction do
      # rubocop:disable Layout/LineLength
      @order.order_dates.map do |d|
        d.destroy if d.year.empty? && d.month.empty? && d.date.empty? && d.start_hour.empty? && d.start_minute.empty? && d.end_hour.empty? && d.end_minute.empty?
      end
      @order.save!
      # rubocop:enable Layout/LineLength

      # TODO: EOS入力にすればタブが入ってしまったようなmessageは解消が可能
      message = <<EOS
        リクエスト内容
        #{@order.title}

        希望日時
        #{parse_order_date(@order.order_dates)}

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
      slack_message = <<~EOS
        会社名: #{current_user.company.name}
        管理画面URL: #{admin_company_url(current_user.company.id)}
        担当者名: #{current_user.company.person_in_charge_name}
        電話番号: #{current_user.company.tel}

        レク名: #{@recreation.title}
        パートナー名: #{@recreation.instructor_name}
        ------------------
        #{message}
      EOS

      # TODO: jobで回した方が良い
      CustomerChatStartMailer.notify(@order, current_user).deliver_now
      PartnerChatStartMailer.notify(@order, current_user).deliver_now

      SlackNotifier.new(channel: '#料金お問い合わせ').send('新規お問い合わせ', slack_message)
      # orderの詳細に飛ばす
      redirect_to chat_customers_order_path(@order.id)
    end
  rescue StandardError
    render :new
  end

  def update
    ActiveRecord::Base.transaction do
      date = params_create[:order_dates_attributes].to_h['0']

      start_at = Time.zone.local(
        date['year'].to_i,
        date['month'].to_i,
        date['date'].to_i,
        date['start_hour'].to_i,
        date['start_minute'].to_i
      )

      end_at = Time.zone.local(
        date['year'].to_i,
        date['month'].to_i,
        date['date'].to_i,
        date['end_hour'].to_i,
        date['end_minute'].to_i
      )

      # TODO: 若干負債だけど、今は許容する
      @order.update(start_at: start_at, end_at: end_at)

      @order.update!(params_create)

      # TODO: jobで送信したい
      OrderRequestMailer.notify(@order, current_user).deliver_now
      redirect_to complete_customers_order_path(@order.id), notice: '正式に依頼しました'
    end
  rescue StandardError
    redirect_to chat_customers_order_path(@order.id), alert: '失敗しました。もう一度お試しください'
  end
  # rubocop:enable Metrics/AbcSize, Naming/HeredocDelimiterNaming

  private

  def set_recreation
    @recreation = Recreation.find(params[:recreation_id])
  end

  def set_order
    @order = current_user.orders.order_asc.find(params[:id])
  end

  # rubocop:disable Layout/LineLength
  def parse_order_date(dates)
    return '' if dates.blank?

    str = ''
    dates.each_with_index do |date, i|
      str += "#{i + 1}:#{date.year}/#{date.month}/#{date.date} #{date.start_hour}:#{date.start_minute}~#{date.end_hour}:#{date.end_minute}\n"
    end

    str
  end
  # rubocop:enable Layout/LineLength

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
      { tags: [] },
      order_dates_attributes: %i[
        id year month date start_hour start_minute end_hour end_minute
      ]
    )
  end
end
