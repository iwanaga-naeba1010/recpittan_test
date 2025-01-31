# frozen_string_literal: true

class FinalCheckMailer < ApplicationMailer
  def notify(order:)
    @template = template_by_kind(kind: 'final_check')
    @order = order

    mail(
      from: 'info@everyplus.jp',
      to: @order.recreation.user.email,
      subject: format(@template['title'], start_at: @order.start_at&.strftime('%Y.%m.%d %H:%M'),
                                          facility_name: @order.user.company.facility_name),
      template_path: 'common_mailer_template'
    )
  end
end
