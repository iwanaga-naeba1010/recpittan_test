# frozen_string_literal: true

class ChatMailer < ApplicationMailer
  def notify(order)
    template = EmailTemplate.find_by(kind: 5)
    @recreation = order.recreation
    @partner = User.find(@recreation.user_id)
    @url = chat_partners_order_url(order.id)

    mail from: 'info@everyplus.jp', to: @partner.email, subject: template.title
  end
end
