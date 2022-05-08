# frozen_string_literal: true

class CustomerPasswordChangeMailer < ApplicationMailer
  def notify(user)
    return if user.blank?

    @template = EmailTemplate.find_by(kind: 'customer_password_change')
    @user_name = user.username
    @email = user.email
    @url = edit_user_password_url

    mail from: 'info@everyplus.jp', to: @email, subject: @template.title, template_path: 'common_mailer_template'
  end
rescue StandardError => e
  Rails.logger.error e
end
