# frozen_string_literal: true

class OrderDenyMailer < ApplicationMailer
  def notify(order:)
    return log_skip(order) if order.is_managercontrol

    @template = template_by_kind(kind: 'order_deny')
    @order = order

    mail(
      from: 'info@everyplus.jp',
      to: @order.user.email,
      subject: @template['title'],
      template_path: 'common_mailer_template'
    )
  end

  private

  def log_skip(order)
    Rails.logger.info "Skipping email CustomerChatStartMailer: Order #{order.id} is controlled by manager."
  end
end
