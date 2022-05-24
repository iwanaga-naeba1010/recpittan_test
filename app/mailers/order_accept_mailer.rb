# frozen_string_literal: true

class OrderAcceptMailer < ApplicationMailer
  def notify(order:)
    @template = EmailTemplate.find_by(kind: 'order_accept')
    @order = order

    mail(
      from: 'info@everyplus.jp',
      to: @order.user.email,
      subject: @template.title,
      template_path: 'common_mailer_template'
    )
  end
end
