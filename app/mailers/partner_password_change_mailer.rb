# frozen_string_literal: true

class PartnerPasswordChangeMailer < ApplicationMailer
  def notify(user)
    @template = EmailTemplate.find_by(kind: 'partner_password_change')
    @user_name = user.username
    @email = user.email
    @url = edit_user_password_url

    mail from: 'info@everyplus.jp', to: @email, subject: @template.title, template_path: 'common_mailer_template'
  end
end
