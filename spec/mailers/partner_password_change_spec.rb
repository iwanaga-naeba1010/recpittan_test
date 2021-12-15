# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PartnerPasswordChangeMailer, type: :mailer do
  let!(:template) { create :email_template, kind: 11 }
  let(:customer) { create :user, :with_custoemr }

  describe 'chat_start' do
    let(:mail) { PartnerPasswordChangeMailer.notify(customer) }

    it 'renders the subject' do
      expect(mail.subject).to eq(template.title)
    end

    it 'renders the reciever email' do
      expect(mail.to).to eq([customer.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['info@everyplus.jp'])
    end

    it 'renders the body' do
      expect(mail.body.parts.first.decoded).to match('MyText')
    end
  end
end
