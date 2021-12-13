# frozen_string_literal: true

class ChatStartMailer < ApplicationMailer
  def notify(recreation, order)
    template = EmailTemplate.find_by(kind: 4)
    @partner = User.find(recreation.user_id)
    @recreation = recreation
    @url = chat_partners_order_url(order.id)

    mail from: 'info@everyplus.jp', to: @partner.email, subject: template.title
  end
end
