class DeviseCustomMailer < Devise::Mailer
  def confirmation_instructions(record, token, opts = {})
    # TODO enumで再定義
    @template = EmailTemplate.find_by(kind: 1)

    super(record, token, opts.merge(
      subject: @template.title
    ))
  end
end
