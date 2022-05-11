# frozen_string_literal: true

class ReportAcceptMailer < ApplicationMailer
  def notify(order)
    @template = EmailTemplate.find_by(kind: 'report_accept')
    @recreation = order.recreation
    @user = @recreation.user
    @user_name = @user.username
    @email = @user.email

    mail from: 'info@everyplus.jp', to: @email, subject: @template.title, template_path: 'common_mailer_template'
  end
end
