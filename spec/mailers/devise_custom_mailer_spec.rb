# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DeviseCustomMailer, type: :mailer do
  include_context 'with email templates'
  let!(:template) { templates.find { |t| t['kind'] == 'customer_email_authentication' } }
  let(:user) { create(:user) }
  let(:token) { 'faketoken123' }

  describe 'confirmation_instructions' do
    let(:mail) { DeviseCustomMailer.confirmation_instructions(user, token) }

    it 'renders the subject' do
      expect(mail.subject).to eq(template['title'])
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['no-reply@ep.net'])
    end
  end
end
