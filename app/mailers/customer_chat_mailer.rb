# frozen_string_literal: true

class CustomerChatMailer < ApplicationMailer
  def notify(order:)
    @template = templates.find { |t| t['kind'] == 'customer_chat' }
    @order = order

    mail(
      from: 'info@everyplus.jp',
      to: @order.user.email,
      subject: @template['title'],
      template_path: 'common_mailer_template'
    )
  end
end
