# frozen_string_literal: true

class FinalCheckMailer < ApplicationMailer
  def notify(order)
    @template = EmailTemplate.find_by(kind: 'final_check')
    @recreation = order.recreation
    @user = @recreation.user
    @user_name = @user.username
    @email = @user.email

    @check_url = "https://recreation.everyplus.jp/partners/orders/#{order.id}/final_check"
    @report_url = "https://recreation.everyplus.jp/partners/orders/#{order.id}/reports/new"

    mail from: 'info@everyplus.jp', to: @email, subject: @template.title, template_path: 'template_mailer'
  end
end
