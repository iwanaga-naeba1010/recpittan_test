# frozen_string_literal: true

class OrderRequestMailer < ApplicationMailer
  def notify(order:)
    @template = template_by_kind(kind: 'order_request')
    @order = order

    mail(
      from: 'info@everyplus.jp',
      to: @order.recreation.user.email,
      subject: @template['title'],
      template_path: 'common_mailer_template'
    )
  end
end
