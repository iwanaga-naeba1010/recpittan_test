# frozen_string_literal: true

class CustomerChatMailer < ApplicationMailer
  def notify(order)
    return if order.blank?

    @template = EmailTemplate.find_by(kind: 'customer_chat')
    @recreation = order.recreation
    user = order.user
    @email = user.email
    @user_name = user.username
    @url = chat_customers_order_url(order.id)

    mail from: 'info@everyplus.jp', to: @email, subject: @template.title, template_path: 'common_mailer_template'
  end
rescue StandardError => e
  Rails.logger.error e
end
