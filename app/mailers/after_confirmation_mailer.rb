# frozen_string_literal: true

class AfterConfirmationMailer < ApplicationMailer
  def notify(user:)
    @template = template_by_kind(kind: 'after_confirmation')
    @user = user

    mail(
      from: 'info@everyplus.jp',
      to: @user.email,
      subject: @template['title'],
      template_path: 'common_mailer_template'
    )
  end
end
