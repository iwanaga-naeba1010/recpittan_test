# frozen_string_literal: true

class OrderAcceptMailer < ApplicationMailer
  def notify(order)
    @template = EmailTemplate.find_by(kind: 'order_accept')
    @recreation = order.recreation
    user = order.user
    @email = user.email
    @user_name = user.username
    @url = customers_url

    mail from: 'info@everyplus.jp', to: @email, subject: @template.title, template_path: 'template_mailer'
  end
end
