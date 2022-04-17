# frozen_string_literal: true

class CustomerChatStartMailer < ApplicationMailer
  def notify(order, user)
    @template = EmailTemplate.find_by(kind: 'customer_chat_start')
    @recreation = order.recreation
    @email = user.email
    @user_name = user.username
    @url = chat_customers_order_url(order.id)

    mail from: 'info@everyplus.jp', to: @email, subject: @template.title, template_path: 'template_mailer'
  end
end
