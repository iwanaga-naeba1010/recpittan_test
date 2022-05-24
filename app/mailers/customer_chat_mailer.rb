# frozen_string_literal: true

class CustomerChatMailer < ApplicationMailer
  def notify(order:)
    @template = EmailTemplate.find_by(kind: 'customer_chat')
    @order = order
    # user = order.user
    # @email = user.email
    # @user_name = user.username
    # @url = chat_customers_order_url(order.id)

    mail(
      from: 'info@everyplus.jp',
      to: @order.user.email,
      subject: @template.title,
      template_path: 'common_mailer_template'
    )
  end
end
