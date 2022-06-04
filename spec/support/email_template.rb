# frozen_string_literal: true

RSpec.shared_context 'with email templates' do
  let!(:templates) do
    path = Rails.root.join('email_template.yml')
    YAML.load_file(path)
  end
end
