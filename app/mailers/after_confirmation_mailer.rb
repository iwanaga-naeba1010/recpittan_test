# frozen_string_literal: true

class AfterConfirmationMailer < ApplicationMailer
  def notify(user)
    @template = EmailTemplate.find_by(kind: 'after_confirmation')
    @user_name = user.username
    @url = customers_recreations_url

    mail from: 'info@everyplus.jp', to: user.email, subject: @template.title, template_path: 'template_mailer'
  end
end
