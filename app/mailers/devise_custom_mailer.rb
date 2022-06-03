# frozen_string_literal: true

class DeviseCustomMailer < Devise::Mailer
  def confirmation_instructions(record, token, opts = {})
    path = Rails.root.join('email_template.yml')
    @template = YAML.load_file(path).find { |t| t['kind'] == 'customer_email_authentication' }

    super(record, token, opts.merge(
      subject: @template['title']
    ))
  end
end
