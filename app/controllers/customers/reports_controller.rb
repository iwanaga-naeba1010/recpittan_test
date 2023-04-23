# frozen_string_literal: true

class Customers::ReportsController < Customers::ApplicationController
  before_action :set_report

  def edit
    @report.build_evaluation
  end

  # rubocop:disable Metrics/AbcSize
  def update
    order = @report.order
    order.report.status = params_create[:status]
    order.report.build_evaluation(params_create[:evaluation_attributes])
    if order.report.update(params_create)
      # NOTE: statusを更新する必要は一切ないが、更新しないとstatusが動的に変更しないためHACK的な感じで実装
      order.update(status: :final_report_admits_not)
      message = <<~MESSAGE
        開催日： #{order.start_at}
        パートナー名： #{order.recreation.profile_name}
        レク名： #{order.recreation_title}
        施設名： #{order.user.company.facility_name}
        レポート本文： #{@report.evaluation_message}
        管理画面案件URL #{admin_order_url(order.id)}
      MESSAGE
      SlackNotifier.new(channel: '#アクティブチャットスレッド').send('施設が終了報告をしました', message)

      if order.report_status&.denied?
        ReportDenyMailer.notify(order:).deliver_now
      end

      if order.report_status&.accepted?
        ReportAcceptMailer.notify(order:).deliver_now
      end

      redirect_to customers_order_path(order.id), notice: t('action_messages.created', model_name: Report.model_name.human)
    else
      render :edit
    end
  end
  # rubocop:enable Metrics/AbcSize

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
        message other_message price is_public _destroy
      ]
    )
  end
end
