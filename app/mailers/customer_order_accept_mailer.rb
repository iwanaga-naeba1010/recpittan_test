# frozen_string_literal: true

class CustomerOrderAcceptMailer < ApplicationMailer
  def notify(order, user)
    template = EmailTemplate.find_by(kind: 6)
    @recreation = order.recreation
    @email = user.email
    @user_name = user.username
    @url = customers_recreation_url(@recreation.id)

    mail from: 'info@everyplus.jp', to: @email, subject: template.title
  end
end
