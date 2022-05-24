# frozen_string_literal: true

class ReportAcceptMailer < ApplicationMailer
  def notify(order:)
    @template = EmailTemplate.find_by(kind: 'report_accept')
    @order = order
    # @recreation = order.recreation
    # @user = @recreation.user
    # @user_name = @user.username
    # @email = @user.email

    mail(
      from: 'info@everyplus.jp',
      to: @order.recreation.user.email,
      subject: @template.title,
      template_path: 'common_mailer_template'
    )
  end
end
