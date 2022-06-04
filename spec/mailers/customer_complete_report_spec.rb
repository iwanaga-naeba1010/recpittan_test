# frozen_string_literal: true

require 'rake'
require 'rails_helper'

RSpec.describe CustomerCompleteReportMailer, type: :mailer do
  include_context 'with email templates'
  let!(:template) { templates.find { |t| t['kind'] == 'customer_complete_report' } }
  let(:partner) { create :user, :with_recreations }
  let(:customer) { create :user, :with_customer }
  let(:order) { create :order, :with_report, recreation_id: partner.recreations.first.id, user_id: customer.id }

  describe 'chat_start' do
    let(:mail) { CustomerCompleteReportMailer.notify(order: order) }

    it 'renders the subject' do
      expect(mail.subject).to eq(template['title'])
    end

    it 'renders the reciever email' do
      expect(mail.to).to eq([customer.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['info@everyplus.jp'])
    end

    # it 'renders the body' do
    #   expect(mail.body.parts.first.decoded).to match('MyText')
    # end
  end
end
