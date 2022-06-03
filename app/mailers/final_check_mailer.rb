# frozen_string_literal: true

class FinalCheckMailer < ApplicationMailer
  def notify(order:)
    @template = templates.find { |t| t['kind'] == 'final_check' }
    @order = order

    mail(
      from: 'info@everyplus.jp',
      to: @order.recreation.user.email,
      subject: @template['title'],
      template_path: 'common_mailer_template'
    )
  end
end
