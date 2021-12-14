# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReportAcceptMailer, type: :mailer do
  let!(:template) { create :email_template, kind: 16 }
  let(:partner) { create :user, :with_recreations }
  let(:customer) { create :user, :with_custoemr }
  let(:order) { create :order, recreation_id: partner.recreations.first.id, user_id: customer.id }

  describe 'chat_start' do
    let(:mail) { ReportAcceptMailer.notify(order) }

    it 'renders the subject' do
      expect(mail.subject).to eq(template.title)
    end

    it 'renders the reciever email' do
      expect(mail.to).to eq([partner.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['info@everyplus.jp'])
    end

    it 'renders the body' do
      expect(mail.body.parts.first.decoded).to match('MyText')
    end
  end
end
