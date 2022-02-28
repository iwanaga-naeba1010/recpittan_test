# frozen_string_literal: true

class PartnerCompleteReportMailer < ApplicationMailer
  def notify(order)
    @template = EmailTemplate.find_by(kind: 'partner_complete_report')
    @recreation = order.recreation
    @user = @recreation.user
    @user_name = @user.username
    @email = @user.email

    @url = "https://recreation.everyplus.jp/partners/orders/#{order.id}/reports/new"

    mail from: 'info@everyplus.jp', to: @email, subject: @template.title
  end
end
