# frozen_string_literal: true

class ReportDenyMailer < ApplicationMailer
  def notify(order)
    # TODO enumで再定義
    @template = EmailTemplate.find_by(kind: 'report_deny')
    @recreation = order.recreation
    @user = @recreation.user
    @user_name = @user.username
    @email = @user.email

    mail from: 'info@everyplus.jp', to: @email, subject: @template.title
  end
end
