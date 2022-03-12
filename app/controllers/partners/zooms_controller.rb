# frozen_string_literal: true

class Partners::ZoomsController < Partners::ApplicationController
  before_action :set_order
  before_action :restrict_modification_for_created_by_admin

  def new
    @zoom = @order.build_zoom
  end

  def create
    @order.build_zoom(params_create)
    if @order.save
      SlackNotifier
        .new(channel: '#アクティブチャットスレッド')
        .send('パートナーがZoomを更新しました', "管理画面案件URL：#{admin_order_url(@order.id)}")
      redirect_to partners_order_path(@order.id), notice: 'Zoom情報を追加しました'
    else
      render :new
    end
  end

  def edit
    @zoom = @order.zoom
  end

  def update
    if @order.zoom.update(params_create)
      SlackNotifier
        .new(channel: '#アクティブチャットスレッド')
        .send('パートナーがZoomを更新しました', "管理画面案件URL：#{admin_order_url(@order.id)}")
      redirect_to partners_order_path(@order.id), notice: 'Zoom情報を変更しました'
    else
      render :edit
    end
  end

  private

  def set_order
    @order = current_user.recreations.map do |rec|
      rec.orders.map { |order| order if order.id == params[:order_id].to_i }
    end.flatten.compact.first
  end

  def params_create
    params.require(:zoom).permit(:url, :price, :created_by)
  end

  def restrict_modification_for_created_by_admin
    zoom = @order.zoom
    return if zoom.nil?

    if zoom.created_by.admin?
      redirect_to partners_order_path(@order.id), alert: '管理者が登録したZoom情報は変更できません'
    end
  end
end
