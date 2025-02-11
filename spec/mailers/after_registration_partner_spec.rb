# frozen_string_literal: true

require 'rails_helper'
require 'rake'

RSpec.describe AfterRegistrationPartnerMailer, type: :mailer do
  include_context 'with email templates'
  let!(:template) { templates.find { |t| t['kind'] == 'after_registration_partner' } }
  let(:partner) { create :user, :with_recreations }

  describe 'notify' do
    let(:mail) { AfterRegistrationPartnerMailer.notify(user: partner) }

    it 'renders the subject' do
      expect(mail.subject).to eq(template['title'])
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([partner.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['info@everyplus.jp'])
    end
  end
end
