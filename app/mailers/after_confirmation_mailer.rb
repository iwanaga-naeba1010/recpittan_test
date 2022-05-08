# frozen_string_literal: true

class AfterConfirmationMailer < ApplicationMailer
  def notify(user)
    return if user.blank?

    @template = EmailTemplate.find_by(kind: 'after_confirmation')
    @user_name = user.username
    @url = customers_recreations_url

    mail from: 'info@everyplus.jp', to: user.email, subject: @template.title, template_path: 'common_mailer_template'
  end
rescue StandardError => e
  Rails.logger.error e
end
