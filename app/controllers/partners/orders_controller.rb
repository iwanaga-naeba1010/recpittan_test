# frozen_string_literal: true

class Partners::OrdersController < Partners::ApplicationController
  before_action :set_order

  def show; end

  def chat
    @chat = current_user.chats.build(order_id: @order.id)
  end

  def update
    # TODO: 承認した場合はis_accepted = trueする
    # TODO: 拒否した場合は、date_and_timeをnilにする
    @order.update(params_create)
    redirect_to partners_order_path(@order.id)
  end

  def confirm
    is_confirm = params[:is_confirm]

    if is_confirm == 'deny'
      return render 'partners/orders/deny'
    elsif is_confirm == 'accept'
      return render 'partners/orders/accept'
    end
  end

  private

  def set_order
    @order = current_user.recreations.map do |rec|
      rec.orders.map { |order| order if order.id == params[:id].to_i }
    end.flatten.compact.first
  end

  def params_create
    params.require(:order).permit(:status, :is_accepted, :date_and_time)
  end
end
