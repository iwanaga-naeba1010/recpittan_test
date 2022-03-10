# frozen_string_literal: true

class Partners::ReportsController < Partners::ApplicationController
  before_action :set_order
  before_action :restrict_initialization, except: %i[edit update confirm]

  def new
    @report = @order.build_report
  end

  def create
    @order.build_report(params_create)
    # NOTE: 冗長だけど、更新のために必要
    @order.status = :final_report_admits_not
    @order.number_of_people = params_create[:number_of_people]
    @order.transportation_expenses = params_create[:transportation_expenses]
    @order.expenses = params_create[:transportation_expenses]
    @order.number_of_facilities = params_create[:number_of_facilities]

    if @order.save
      CustomerCompleteReportMailer.notify(@order).deliver_now
      redirect_to partners_order_path(@order.id), notice: '終了報告を投稿しました！'
    else
      render :new
    end
  end

  def edit
    @report = @order.report
  end

  def update
    if @order.report.update(params_create)
      @order.update(
        status: :final_report_admits_not,
        number_of_people: params_create[:number_of_people],
        transportation_expenses: params_create[:transportation_expenses].to_i,
        expenses: params_create[:expenses].to_i,
        number_of_facilities: params_create[:number_of_facilities].to_i
      )
      CustomerCompleteReportMailer.notify(@order).deliver_now
      redirect_to partners_order_path(@order.id), notice: '終了報告を更新しました！'
    else
      render :edit
    end
  end

  def confirm
    is_confirm = params[:is_confirm]
    return render 'partners/orders/deny' if is_confirm == 'deny'

    render 'partners/orders/accept' if is_confirm == 'accept'
  end

  def complete; end

  private

  def set_order
    @order = current_user.recreations.map do |rec|
      rec.orders.map { |order| order if order.id == params[:order_id].to_i }
    end.flatten.compact.first
  end

  def params_create
    params.require(:report).permit(
      :body, :expenses, :number_of_facilities,
      :number_of_people, :transportation_expenses
    )
  end

  def restrict_initialization
    redirect_to edit_partners_order_report_path(id: @order.report, order_id: @order), alert: '終了報告は作成済みです' if @order.report.present?
  end
end
