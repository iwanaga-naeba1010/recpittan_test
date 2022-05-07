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
    if params[:redirect_path]
      redirect_path = params[:redirect_path]
    end
    if params[:message]
      message = params[:message]
    end

    @order.update(params_create)

    if params_create[:is_accepted] == 'true'
      OrderAcceptMailer.notify(@order).deliver_now
    end

    if params_create[:is_accepted] == 'false'
      OrderDenyMailer.notify(@order).deliver_now
    end
    redirect_to redirect_path, notice: message
  end

  def confirm
    is_confirm = params[:is_confirm]

    if @order.recreation.is_online
      @path = new_partners_order_zoom_path(@order)
    else
      @path = partners_order_path(@order)
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
      パートナー名： #{@order.recreation.profile_name}
      管理画面案件URL： #{admin_order_url(@order.id)}
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
    params.require(:order).permit(:status, :is_accepted, :start_at)
  end
end
