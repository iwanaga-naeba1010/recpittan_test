# frozen_string_literal: true

class FinalCheckMailer < ApplicationMailer
  def notify(order:)
    @template = template_by_kind(kind: 'final_check')
    @order = order
    @path = ENV.fetch('APP_PATH')

    mail(
      from: 'info@everyplus.jp',
      to: @order.recreation.user.email,
      subject: @template['title'],
      template_path: 'common_mailer_template'
    )
  end
end
