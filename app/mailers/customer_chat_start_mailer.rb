# frozen_string_literal: true

class CustomerChatStartMailer < ApplicationMailer
  def notify(order, user)
    template = EmailTemplate.find_by(kind: 4)
    @recreation = order.recreation
    @email = user.email
    @user_name = user.username
    @url = chat_customers_order_url(order.id)

    mail from: 'info@everyplus.jp', to: @email, subject: template.title
  end
end
