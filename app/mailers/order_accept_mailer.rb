# frozen_string_literal: true

class OrderAcceptMailer < ApplicationMailer
  def notify(order)
    # TODO enumで再定義
    @template = EmailTemplate.find_by(kind: 6)
    @recreation = order.recreation
    user = order.user
    @email = user.email
    @user_name = user.username
    @url = customers_recreation_url(@recreation.id)

    mail from: 'info@everyplus.jp', to: @email, subject: @template.title
  end
end
