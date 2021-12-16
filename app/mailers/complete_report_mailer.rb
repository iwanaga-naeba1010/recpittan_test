# frozen_string_literal: true

class CompleteReportMailer < ApplicationMailer
  def notify(order)
    @template = EmailTemplate.find_by(kind: 17)
    @recreation = order.recreation
    @user = @recreation.user
    @user_name = @user.username
    @email = @user.email
    @url = chat_partners_order_url(order.id)

    mail from: 'info@everyplus.jp', to: @email, subject: @template.title
  end
end
