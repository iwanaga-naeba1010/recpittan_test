# frozen_string_literal: true

class CustomerChatMailer < ApplicationMailer
  def notify(order)
    # TODO enumで再定義
    @template = EmailTemplate.find_by(kind: 5)
    @recreation = order.recreation
    user = order.user
    @email = user.email
    @user_name = user.username
    @url = chat_customers_order_url(order.id)

    mail from: 'info@everyplus.jp', to: @email, subject: @template.title
  end
end
