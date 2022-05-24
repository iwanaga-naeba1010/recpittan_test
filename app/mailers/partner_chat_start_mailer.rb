# frozen_string_literal: true

class PartnerChatStartMailer < ApplicationMailer
  def notify(order:)
    @template = EmailTemplate.find_by(kind: 'partner_chat_start')
    @order = order
    # @recreation = order.recreation
    # @user = @recreation.user
    # @user_name = @user.username
    # @email = @user.email
    # @facility_name = customer_user.company.name
    # @url = chat_partners_order_url(order.id)

    mail(
      from: 'info@everyplus.jp',
      to: @order.recreation.user.email,
      subject: @template.title,
      template_path: 'common_mailer_template'
    )
  end
end
