# frozen_string_literal: true

class OrderDenyMailer < ApplicationMailer
  def notify(order:)
    @template = template_by_kind(kind: 'order_deny')
    @order = order

    mail(
      from: 'info@everyplus.jp',
      to: @order.user.email,
      subject: @template['title'],
      template_path: 'common_mailer_template'
    )
  end
end
