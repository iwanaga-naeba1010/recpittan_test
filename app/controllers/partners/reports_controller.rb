# frozen_string_literal: true

class Partners::ReportsController < Partners::ApplicationController
  before_action :set_order

  def new
    @report = @order.build_report
  end

  def create
    @order.build_report(params_create)

    if @order.save
      redirect_to partners_order_path(@order.id), notice: 'レポートを投稿しました！'
    else
      render :new
    end
  end

  def edit
    @report = @order.report
  end

  def update
    if @order.report.update(params_create)
      @order.update(status: :final_report_admits_not)
      redirect_to partners_order_path(@order.id), notice: 'レポートを更新しました！'
    else
      render :edit
    end
  end

  def confirm
    is_confirm = params[:is_confirm]

    if is_confirm == 'deny'
      return render 'partners/orders/deny'
    elsif is_confirm == 'accept'
      return render 'partners/orders/accept'
    end
  end

  def complete
  end

  private

  def set_order
    @order = current_user.recreations.map do |rec|
      rec.orders.map { |order| order if order.id == params[:order_id].to_i }
    end.flatten.compact.first
  end

  def params_create
    params.require(:report).permit(
      :body, :expenses, :facility_count,
      :number_of_people, :number_of_people, :transportation_expenses
    )
  end
end
