# frozen_string_literal: true

class PartnerCompleteReportMailer < ApplicationMailer
  def notify(order)
    return if order.blank?

    @template = EmailTemplate.find_by(kind: 'partner_complete_report')
    @recreation = order.recreation
    @user = @recreation.user
    @user_name = @user.username
    @email = @user.email

    @url = "https://recreation.everyplus.jp/partners/orders/#{order.id}/reports/new"

    mail from: 'info@everyplus.jp', to: @email, subject: @template.title, template_path: 'common_mailer_template'
  end
rescue StandardError => e
  Rails.logger.error e
end
