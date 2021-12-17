# frozen_string_literal: true

class OrderDenyMailer < ApplicationMailer
  def notify(order)
    @template = EmailTemplate.find_by(kind: 'order_deny')
    @recreation = order.recreation
    user = order.user
    @email = user.email
    @user_name = user.username
    @url = chat_customers_order_url(order.id)

    mail from: 'info@everyplus.jp', to: @email, subject: @template.title
  end
end
