# frozen_string_literal: true

require 'rake'
require 'rails_helper'

RSpec.describe CustomerPasswordChangeMailer, type: :mailer do
  include_context 'with email templates'
  let!(:template) { templates.find { |t| t['kind'] == 'customer_password_change' } }
  let(:customer) { create :user, :with_customer }

  describe 'chat_start' do
    let(:mail) { CustomerPasswordChangeMailer.notify(user: customer) }

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
