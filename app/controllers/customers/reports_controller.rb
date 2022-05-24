# frozen_string_literal: true

class Customers::ReportsController < Customers::ApplicationController
  before_action :set_report

  def edit
    @report.build_evaluation
  end

  def update
    order = @report.order
    order.report.status = params_create[:status]
    order.report.build_evaluation(params_create[:evaluation_attributes])
    if order.report.update(params_create)
      # NOTE: statusを更新する必要は一切ないが、更新しないとstatusが動的に変更しないためHACK的な感じで実装
      order.update(status: :final_report_admits_not)

      if order.report_status&.denied?
        ReportDenyMailer.notify(order: order).deliver_now
      end

      if order.report_status&.accepted?
        ReportAcceptMailer.notify(order: order).deliver_now
      end

      redirect_to customers_order_path(order.id), notice: t('action_messages.created', model_name: Report.model_name.human)
    else
      render :edit
    end
  end

  private def set_report
    @report = current_user.orders.map do |order|
      order.report if order&.report&.id == params[:id].to_i
    end.compact&.first
  end

  private def params_create
    params.require(:report).permit(
      :status,
      evaluation_attributes: %i[
        id report_id ingenuity communication smoothness want_to_order_agein
        message other_message price _destroy
      ]
    )
  end
end
