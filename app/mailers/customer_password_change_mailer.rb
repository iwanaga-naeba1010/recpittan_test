# frozen_string_literal: true

class CustomerPasswordChangeMailer < ApplicationMailer
  def notify(user)
    @template = EmailTemplate.find_by(kind: 'customer_password_change')
    @user_name = user.username
    @email = user.email
    @url = edit_user_password_url

    mail from: 'info@everyplus.jp', to: @email, subject: @template.title, template_path: 'template_mailer'
  end
end
