# frozen_string_literal: true

class Partners::ZoomsController < Partners::ApplicationController
  before_action :set_order
  before_action :restrict_modification_for_created_by_admin

  def new
    @zoom = @order.build_zoom
  end

  def edit
    @zoom = @order.zoom
  end

  def create
    @order.build_zoom(params_create)
    if @order.save
      SlackNotifier
        .new(channel: '#アクティブチャットスレッド')
        .send('パートナーがZoomを更新しました', "管理画面案件URL：#{admin_order_url(@order.id)}")
      redirect_to partners_order_path(@order.id), notice: t('action_messages.created', model_name: Zoom.model_name.human)
    else
      render :new
    end
  end

  def update
    if @order.zoom.update(params_create)
      SlackNotifier
        .new(channel: '#アクティブチャットスレッド')
        .send('パートナーがZoomを更新しました', "管理画面案件URL：#{admin_order_url(@order.id)}")
      redirect_to partners_order_path(@order.id), notice: t('action_messages.updated', model_name: Zoom.model_name.human)
    else
      render :edit
    end
  end

  private def set_order
    @order = current_user.recreations.map do |rec|
      rec.orders.map { |order| order if order.id == params[:order_id].to_i }
    end.flatten.compact.first
  end

  private def params_create
    params.require(:zoom).permit(:url, :price, :created_by)
  end

  private def restrict_modification_for_created_by_admin
    zoom = @order.zoom
    return if zoom.nil?

    if zoom.created_by.admin?
      redirect_to partners_order_path(@order.id), alert: t('action_messages.unauthorized')
    end
  end
end
