class DeviseCustomMailer < Devise::Mailer
  def confirmation_instructions(record, token, opts = {})
    subject = EmailTemplate.find_by(kind: 1)

    super(record, token, opts.merge(
      subject: subject.title
    ))
  end
end
