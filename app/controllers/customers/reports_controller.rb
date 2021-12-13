# frozen_string_literal: true

class Customers::ReportsController < Customers::ApplicationController
  before_action :set_report

  def edit; end

  def update
    if @order.update(params_create)
      redirect_to customers_order_path(@order.id), notice: '終了報告を更新しました'
    else
      render :edit
    end
  end

  private

  def set_report
    @report = current_user.orders.map do |order|
      order.report if order&.report&.id == params[:id].to_i
    end.compact&.first
  end

  def params_create
    params.require(:report).permit(
      :body, :expenses, :facility_count, :is_accepted,
      :additional_number_of_people, :number_of_people, :transportation_expenses
    )
  end
end
