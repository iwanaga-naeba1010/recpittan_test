# frozen_string_literal: true

class FinalCheckMailer < ApplicationMailer
  def notify(user)
    @template = EmailTemplate.find_by(kind: 'final_check')
    @recreation = order.recreation
    @user = @recreation.user
    @user_name = @user.username
    @email = @user.email

    @url = "https://recreation.everyplus.jp/partners/orders/#{order.id}/final_check"

    mail from: 'info@everyplus.jp', to: @email, subject: @template.title
  end
end
