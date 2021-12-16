# frozen_string_literal: true

class ReportAcceptMailer < ApplicationMailer
  def notify(order)
    template = EmailTemplate.find_by(kind: 16)
    @recreation = order.recreation
    @user = @recreation.user
    @user_name = @user.username
    @email = @user.email

    mail from: 'info@everyplus.jp', to: @email, subject: template.title
  end
end
