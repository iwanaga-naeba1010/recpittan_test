# frozen_string_literal: true

class PartnerCompleteReportMailer < ApplicationMailer
  def notify(order)
    @template = EmailTemplate.find_by(kind: 'partner_complete_report')
    @recreation = order.recreation
    report = order.report
    @user = @recreation.user
    @user_name = @user.username
    @email = @user.email
    @url = partners_order_url(order.id)

    mail from: 'info@everyplus.jp', to: @email, subject: @template.title
  end
end
