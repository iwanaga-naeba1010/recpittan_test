# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderAcceptMailer, type: :mailer do
  let!(:template) { create :email_template, kind: 'order_accept' }
  let(:partner) { create :user, :with_recreations }
  let(:customer) { create :user, :with_custoemr }
  let(:order) { create :order, recreation_id: partner.recreations.first.id, user_id: customer.id }

  describe 'order_accept' do
    let(:mail) { OrderAcceptMailer.notify(order) }

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
