# frozen_string_literal: true

class CustomerCompleteReportMailer < ApplicationMailer
  def notify(order)
    @template = EmailTemplate.find_by(kind: 'customer_complete_report')
    @recreation = order.recreation
    report = order.report
    user = order.user
    @email = user.email
    @user_name = user.username
    @url = edit_customers_report_url(report.id)

    mail from: 'info@everyplus.jp', to: @email, subject: @template.title, template_path: 'template_mailer'
  end
end
