class DeviseCustomMailer < Devise::Mailer
  def confirmation_instructions(record, token, opts = {})
    @template = EmailTemplate.find_by(kind: 1)

    super(record, token, opts.merge(
      subject: @template.title
    ))
  end
end
