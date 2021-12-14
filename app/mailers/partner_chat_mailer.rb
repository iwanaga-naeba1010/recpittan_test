# frozen_string_literal: true

class PartnerChatMailer < ApplicationMailer
  def notify(order, customer_user)
    template = EmailTemplate.find_by(kind: 13)
    @recreation = order.recreation
    @user = User.find(@recreation.user_id)
    @user_name = @user.username
    @email = @user.email
    @facility_name = customer_user.company.name
    @url = chat_partners_order_url(order.id)

    mail from: 'info@everyplus.jp', to: @email, subject: template.title
  end
end
