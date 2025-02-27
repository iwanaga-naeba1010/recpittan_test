# frozen_string_literal: true

require 'rake'
require 'rails_helper'

RSpec.describe CustomerChatStartMailer, type: :mailer do
  include_context 'with email templates'
  let!(:template) { templates.find { |t| t['kind'] == 'customer_chat_start' } }
  let(:partner) { create :user, :with_recreations }
  let(:customer) { create :user, :with_customer }

  describe 'chat_start' do
    let(:mail) { CustomerChatStartMailer.notify(order:) }

    context 'when order is not controlled by manager' do
      let(:order) { create :order, recreation_id: partner.recreations.first.id, user_id: customer.id }

      it 'renders the subject' do
        expect(mail.subject).to eq(template['title'])
      end

      it 'renders the reciever email' do
        expect(mail.to).to eq([customer.email])
      end

      it 'renders the sender email' do
        expect(mail.from).to eq(['info@everyplus.jp'])
      end
    end

    context 'when order is controlled by manager' do
      let(:order) { create :order, recreation_id: partner.recreations.first.id, user_id: customer.id, is_managercontrol: true }

      it 'does not send an email' do
        expect(mail.to).to be_nil
      end
    end
  end
end
