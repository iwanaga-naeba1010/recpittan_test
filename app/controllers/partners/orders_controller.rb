# frozen_string_literal: true

class Partners::OrdersController < Partners::ApplicationController
  before_action :set_order

  def show
    is_accepted = params[:is_accepted]
    if is_accepted == 'true'
      render 'partners/orders/accepted_detail'
    end
  end

  def chat
    @chat = current_user.chats.build(order_id: @order.id)
  end

  def update
    # TODO: 承認した場合はis_accepted = trueする
    # TODO: 拒否した場合は、start_atをnilにする
    redirect_path = partners_order_path(@order)
    message = '更新しました！'

    redirect_path = params[:redirect_path] if params[:redirect_path]
    message = params[:message] if params[:message]
    redirect_path = partners_path(is_open: true) if params[:order][:is_open]

    @order.update(params_create)

    OrderAcceptMailer.notify(order: @order).deliver_now if params_create[:is_accepted] == 'true'
    OrderDenyMailer.notify(order: @order).deliver_now if params_create[:is_accepted] == 'false'

    redirect_to redirect_path, notice: message
  rescue StandardError => e
    Sentry.capture_exception(e)
    redirect_to partners_path(is_open: true), alert: e.message
  end

  def confirm
    is_confirm = params[:is_confirm]

    @path = if @order.recreation_kind.online?
              new_partners_order_zoom_path(@order)
            else
              partners_order_path(@order)
            end

    case is_confirm
    when 'deny'
      render 'partners/orders/deny'
    when 'accept'
      render 'partners/orders/accept'
    end
  end

  def complete; end

  def final_check; end

  def update_final_check
    @order.update(final_check_status: :checked)
    message = <<~MESSAGE
      開催日： #{@order.start_at}
      パートナー名： #{@order.recreation.profile_name}
      レク名： #{@order.recreation_title}
      施設名： #{@order.user.company.facility_name}
      管理画面案件URL #{admin_order_url(@order.id)}
    MESSAGE
    SlackNotifier.new(channel: '#アクティブチャットスレッド').send('パートナーが最終確認を完了しました', message)
    redirect_to complete_final_check_partners_order_path(@order.id)
  end

  def complete_final_check; end

  private def set_order
    @order = current_user.recreations.map do |rec|
      rec.orders.order_asc.map { |order| order if order.id == params[:id].to_i }
    end.flatten.compact.first
  end

  private def params_create
    params.require(:order).permit(:status, :is_accepted, :start_at, :is_open)
  end
end
