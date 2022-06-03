# frozen_string_literal: true

class DeviseCustomMailer < Devise::Mailer
  def confirmation_instructions(record, token, opts = {})
    @template = template_by_kind(kind: 'customer_email_authenticatin')

    super(record, token, opts.merge(
      subject: @template['title']
    ))
  end
end
