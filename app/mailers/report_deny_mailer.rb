# frozen_string_literal: true

class ReportDenyMailer < ApplicationMailer
  def notify(order)
    @template = EmailTemplate.find_by(kind: 'report_deny')
    @recreation = order.recreation
    @user = @recreation.user
    @user_name = @user.username
    @email = @user.email

    # @url = edit_partners_order_report_url(order_id: order.id, id: order.report&.id)
    # NOTE(okubo): なぜかサブドメインが認識されないので、ベタがきで対応
    @url = "https://recreation.everyplus.jp/partners/orders/#{order.id}/reports/#{order.report&.id}/edit"

    mail from: 'info@everyplus.jp', to: @email, subject: @template.title, template_path: 'template_mailer'
  end
end
