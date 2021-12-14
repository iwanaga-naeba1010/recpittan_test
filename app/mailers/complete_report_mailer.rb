# frozen_string_literal: true

class CompleteReportMailer < ApplicationMailer
  def notify(order)
    template = EmailTemplate.find_by(kind: 17)
    @recreation = order.recreation
    @user = User.find(@recreation.user_id)
    @user_name = @user.username
    @email = @user.email
    @url = chat_partners_order_url(order.id)

    mail from: 'info@everyplus.jp', to: @email, subject: template.title
  end
end
