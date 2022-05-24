# frozen_string_literal: true

class FinalCheckMailer < ApplicationMailer
  def notify(order:)
    @template = EmailTemplate.find_by(kind: 'final_check')
    @order = order
    # @user = @recreation.user
    # @user_name = @user.username
    # @email = @user.email

    # @check_url = "https://recreation.everyplus.jp/partners/orders/#{order.id}/final_check"
    # @report_url = "https://recreation.everyplus.jp/partners/orders/#{order.id}/reports/new"

    mail(
      from: 'info@everyplus.jp',
      to: @order.recreation.user.email,
      subject: @template.title,
      template_path: 'common_mailer_template'
    )
  end
end
