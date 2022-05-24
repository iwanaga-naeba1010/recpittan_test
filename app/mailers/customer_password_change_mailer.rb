# frozen_string_literal: true

class CustomerPasswordChangeMailer < ApplicationMailer
  def notify(user:)
    @template = EmailTemplate.find_by(kind: 'customer_password_change')
    @user = user

    mail(
      from: 'info@everyplus.jp',
      to: @user.email,
      subject: @template.title,
      template_path: 'common_mailer_template'
    )
  end
end
