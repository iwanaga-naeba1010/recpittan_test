# frozen_string_literal: true

class PartnerChatStartMailer < ApplicationMailer
  def notify(order, customer_user)
    template = EmailTemplate.find_by(kind: 12)
    @recreation = order.recreation
    @user = @recreation.user
    @user_name = @user.username
    @email = @user.email
    @facility_name = customer_user.company.name
    @url = chat_partners_order_url(order.id)

    mail from: 'info@everyplus.jp', to: @email, subject: template.title
  end
end
