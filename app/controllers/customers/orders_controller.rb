# frozen_string_literal: true

class Customers::OrdersController < Customers::ApplicationController
  before_action :set_recreation, only: %i[new create]
  before_action :set_order, only: %i[show chat complete]

  def show; end

  def new
    @recreation = Recreation.find(params[:recreation_id])
    @order = @recreation.orders.build
    3.times { @order.order_dates.build }
  end

  def chat; end

  def complete
    redirect_to chat_customers_order_path(@order.id) if @order.start_at.blank?
  end

  # rubocop:disable Metrics/AbcSize, Layout/LineLength
  def create
    @order = @recreation.orders.build(params_create)

    ActiveRecord::Base.transaction do
      @order.order_dates.map do |d|
        d.destroy if d.year.empty? && d.month.empty? && d.date.empty? && d.start_hour.empty? && d.start_minute.empty? && d.end_hour.empty? && d.end_minute.empty?
      end.compact
      @order.save!

      message = <<~MESSAGE
        #{@order.title}

        希望日時
        #{parse_order_date(@order.order_dates)}

        希望人数
        #{@order.number_of_people}人

        介護度目安
        #{params_create[:tags]&.join("\n")}

        住所
        #{@order.prefecture}#{@order.city}

        相談したい事
        #{params_create[:message]}
      MESSAGE

      Chat.create(
        order_id: @order.id,
        user_id: current_user.id,
        message:,
        is_read: false
      )

      slack_message = <<~MESSAGE
        会社名: #{current_user.company.name + current_user.company.facility_name}
        管理画面URL: #{admin_company_url(current_user.company.id)}
        担当者名: #{current_user.company.person_in_charge_name}
        電話番号: #{current_user.company.tel}

        レク名: #{@recreation.title}
        パートナー名: #{@recreation.profile_name}
        ------------------
        #{message}
      MESSAGE

      # TODO: jobで回した方が良い
      CustomerChatStartMailer.notify(order: @order).deliver_now
      PartnerChatStartMailer.notify(order: @order).deliver_now

      SlackNotifier.new(channel: '#料金お問い合わせ').send('新規お問い合わせ', slack_message)
      # orderの詳細に飛ばす
      redirect_to chat_customers_order_path(@order.id, isShowFlash: true)
    end
  rescue StandardError => e
    Sentry.capture_exception(e)
    logger.error e.message
    render :new
  end

  private def set_recreation
    @recreation = Recreation.find(params[:recreation_id])
  end

  private def set_order
    @order = current_user.orders.order_asc.find(params[:id])
  end

  private def parse_order_date(dates)
    return '' if dates.blank?

    str = ''
    dates.each_with_index do |date, i|
      str += "#{i + 1}:#{date.year}/#{date.month}/#{date.date} #{date.start_hour}:#{date.start_minute}~#{date.end_hour}:#{date.end_minute}\n"
    end

    str
  end

  private def params_create
    params.require(:order).permit(
      :title, :zip, :prefecture, :city, :street, :building, :status,
      :number_of_people, :number_of_facilities,
      :user_id, :message,
      :kind, :is_accepted,
      :price,
      :amount,
      :material_price,
      :material_amount,
      :additional_facility_fee,
      :start_at,
      :final_check_status,
      { tags: [] },
      order_dates_attributes: %i[
        id year month date start_hour start_minute end_hour end_minute
      ]
    )
  end
  # rubocop:enable Metrics/AbcSize, Layout/LineLength
end
