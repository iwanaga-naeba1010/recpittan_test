# frozen_string_literal: true

class Customers::OrdersController < Customers::ApplicationController
  before_action :set_recreation, only: %i[new create]
  before_action :set_order, only: %i[show chat update complete]

  def new
    @recreation = Recreation.find(params[:recreation_id])
    @order = @recreation.orders.build
  end

  def show; end

  def chat
    @chat = current_user.chats.build(order_id: @order.id)
  end

  def complete
    redirect_to chat_customers_order_path(@order.id) if @order.status.consult?
  end

  # rubocop:disable Metrics/AbcSize
  def create
    @order = @recreation.orders.build(params_create)

    ActiveRecord::Base.transaction do
      @order.save
      dates = params_create.to_h[:dates]

      # TODO: 希望日時が空でも大丈夫なようにする
      # TODO: EOS入力にすればタブが入ってしまったようなmessageは解消が可能
      message = <<EOS
        リクエスト内容
        #{@order.title}
        希望日時
        #{parse_date(dates)}

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
      # orderの詳細に飛ばす
      redirect_to chat_customers_order_path(@order.id)
    end
  # rubocop:disable Lint/UselessAssignment
  rescue StandardError
    render :new
  end
  # rubocop:enable Lint/UselessAssignment

  def update
    date = params_create.to_h[:dates]['0']
    str_to_date = Time.new(date['year'].to_i, date['month'].to_i, date['date'].to_i, date['start_hour'].to_i, date['start_minutes'].to_i)

    # TODO: 若干負債だけど、今は許容する
    @order.update(date_and_time: str_to_date)

    if @order.update(params_create)
      redirect_to complete_customers_order_path(@order.id), notice: '正式に依頼しました'
    else
      redirect_to chat_customers_order_path(@order.id), alert: '失敗しました。もう一度お試しください'
    end
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
      :title, :zip, :prefecture, :city, :street, :building, :status, :number_of_people, :user_id, :message,
      :is_online, :is_accepted, :date_and_time,
      # TODO: datesをobjectではなくarrayでまとめることで多分対応が可能となる
      # TODO: 当然テストや他の箇所のテストなども変わってしまうが、
      # 1. railsはarrayだけを管理すればOK
      # 2. formに値を持たせてそのままrenderingする
      # 3. newだけではなく、正式orderの実行もdates[0]の指定だけで住むので、全体的にコードの可読性が高くなる。
      # ということを期待できるので、非常に良い選択肢と考えられる
      { dates: {} },
      { tags: [] }
    )
  end
end
