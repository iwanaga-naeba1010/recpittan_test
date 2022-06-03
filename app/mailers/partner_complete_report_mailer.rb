# frozen_string_literal: true

class PartnerCompleteReportMailer < ApplicationMailer
  def notify(order:)
    @template = template_by_kind(kind: 'partner_complete_report')
    @order = order

    mail(
      from: 'info@everyplus.jp',
      to: @order.recreation.user.email,
      subject: @template['title'],
      template_path: 'common_mailer_template'
    )
  end
end
