# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  private def template_by_kind(kind:)
    path = Rails.root.join('email_template.yml')
    YAML.load_file(path).find { |t| t['kind'] == kind }
  end
end
