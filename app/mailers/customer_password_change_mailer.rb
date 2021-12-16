# frozen_string_literal: true

class CustomerPasswordChangeMailer < ApplicationMailer
  def notify(user)
    # TODO enumで再定義
    @template = EmailTemplate.find_by(kind: 3)
    @user_name = user.username
    @email = user.email
    @url = edit_user_password_url

    mail from: 'info@everyplus.jp', to: @email, subject: @template.title
  end
end
