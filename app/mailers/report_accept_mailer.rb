# frozen_string_literal: true

class ReportAcceptMailer < ApplicationMailer
  def notify(order:)
    @template = template_by_kind(kind: 'report_accept')
    @order = order

    mail(
      from: 'info@everyplus.jp',
      to: @order.recreation.user.email,
      subject: @template['title'],
      template_path: 'common_mailer_template'
    )
  end
end
